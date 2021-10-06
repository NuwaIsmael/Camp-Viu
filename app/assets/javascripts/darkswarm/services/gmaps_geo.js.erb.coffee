Darkswarm.service "GmapsGeo", ->
  new class GmapsGeo
    OK: google?.maps?.GeocoderStatus?.OK

	@@ -10,7 +10,7 @@ Darkswarm.service "GmapsGeo", ->
    #     console.log "Error: #{status}"
    geocode: (address, callback) ->
      geocoder = new google.maps.Geocoder()
      geocoder.geocode {'address': address, 'region': "<%= Spree::Country.find_by(id: Spree::Config[:default_country_id]).iso %>"}, callback

    distanceBetween: (src, dst) ->
      google.maps.geometry.spherical.computeDistanceBetween @toLatLng(src), @toLatLng(dst)
	@@ -20,4 +20,4 @@ Darkswarm.service "GmapsGeo", ->
      if locatable.lat?
        locatable
      else
        new google.maps.LatLng locatable.latitude, locatable.longitude
