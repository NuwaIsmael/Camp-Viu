# frozen_string_literal: true

module Spree
  class CreditCard < ApplicationRecord
    belongs_to :payment_method
    belongs_to :user

    has_many :payments, as: :source

    before_save :set_last_digits

    attr_accessor :verification_value
    attr_reader :number
    attr_writer :save_requested_by_customer # For holding customer preference in memory

    validates :month, :year, numericality: { only_integer: true }
    validates :number, presence: true, unless: :has_payment_profile?, on: :create
    validates :verification_value, presence: true, unless: :has_payment_profile?, on: :create
    validate :expiry_not_in_the_past

    after_create :ensure_single_default_card
    after_save :ensure_single_default_card, if: :default_card_needs_updating?

    scope :with_payment_profile, -> { where('gateway_customer_profile_id IS NOT NULL') }

    # needed for some of the ActiveMerchant gateways (eg. SagePay)
    alias_attribute :brand, :cc_type

    def expiry=(expiry)
      self[:month], self[:year] = expiry.split(" / ")
      self[:year] = "20" + self[:year]
    end

    def number=(num)
      @number = begin
                  num.gsub(/[^0-9]/, '')
                rescue StandardError
                  nil
                end
    end

    # cc_type is set by jquery.payment, which helpfully provides different
    # types from Active Merchant. Converting them is necessary.
    def cc_type=(type)
      real_type = case type
                  when 'mastercard', 'maestro'
                    'master'
                  when 'amex'
                    'american_express'
                  when 'dinersclub'
                    'diners_club'
                  else
                    type
                  end
      self[:cc_type] = real_type
    end

    def set_last_digits
      number.to_s.gsub!(/\s/, '')
      verification_value.to_s.gsub!(/\s/, '')
      self.last_digits ||= number.to_s.length <= 4 ? number : number.to_s.slice(-4..-1)
    end

    def name?
      first_name? && last_name?
    end

    def name
      "#{first_name} #{last_name}"
    end

    def verification_value?
      verification_value.present?
    end

    # Show the card number, with all but last 4 numbers replace with "X". (XXXX-XXXX-XXXX-4338)
    def display_number
      "XXXX-XXXX-XXXX-#{last_digits}"
    end

    def actions
      %w{capture void credit resend_authorization_email}
    end

    def can_resend_authorization_email?(payment)
      payment.pending? && payment.authorization_action_required?
    end

    # Indicates whether its possible to capture the payment
    def can_capture?(payment)
      return false if payment.authorization_action_required?

      payment.pending? || payment.checkout?
    end

    # Indicates whether its possible to void the payment.
    def can_void?(payment)
      !payment.void?
    end

    # Indicates whether its possible to credit the payment. Note that most gateways require that the
    #   payment be settled first which generally happens within 12-24 hours of the transaction.
    def can_credit?(payment)
      return false unless payment.completed?
      return false unless payment.order.payment_state == 'credit_owed'

      payment.credit_allowed.positive?
    end

    # Allows us to use a gateway_payment_profile_id to store Stripe Tokens
    def has_payment_profile?
      gateway_customer_profile_id.present? || gateway_payment_profile_id.present?
    end

    def to_active_merchant
      ActiveMerchant::Billing::CreditCard.new(
        number: number,
        month: month,
        year: year,
        verification_value: verification_value,
        first_name: first_name,
        last_name: last_name
      )
    end

    def save_requested_by_customer?
      !!@save_requested_by_customer
    end

    private

    def expiry_not_in_the_past
      return unless year.present? && month.present?

      time = "#{year}-#{month}-1".to_time
      return unless time < Time.zone.now.to_time.beginning_of_month

      errors.add(:base, :card_expired)
    end

    def reusable?
      gateway_customer_profile_id.present?
    end

    def default_missing?
      !user.credit_cards.exists?(is_default: true)
    end

    def default_card_needs_updating?
      saved_change_to_is_default? || saved_change_to_gateway_customer_profile_id?
    end

    def ensure_single_default_card
      return unless user
      return unless is_default? || (reusable? && default_missing?)

      user.credit_cards.update_all(['is_default=(id=?)', id])
      self.is_default = true
    end
  end
end
