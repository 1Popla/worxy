function initNewPostMap() {
  var mapElement = document.getElementById('map');
  if (!mapElement) {
    console.error("Map element not found!");
    return;
  }

  var map = new google.maps.Map(mapElement, {
    center: { lat: 52.2297, lng: 21.0122 },
    zoom: 15
  });

  var marker;
  var geocoder = new google.maps.Geocoder();
  var autocomplete = new google.maps.places.Autocomplete(document.getElementById('street'), { types: ['geocode'] });

  autocomplete.addListener('place_changed', function () {
    var place = autocomplete.getPlace();
    if (!place.geometry || !place.geometry.location) {
      console.error("Place geometry is not defined or does not have a valid location.");
      return;
    }

    var location = place.geometry.location;
    var lat = location.lat();
    var lng = location.lng();

    if (isNaN(lat) || isNaN(lng)) {
      console.error("Invalid location coordinates:", location);
      return;
    }

    // Update latitude and longitude fields
    document.getElementById('latitude').value = lat;
    document.getElementById('longitude').value = lng;

    console.log("Setting map center to:", location);
    console.log("Latitude:", lat, "Longitude:", lng);

    map.setCenter({ lat: lat, lng: lng });
    map.setZoom(17);

    if (marker) {
      marker.setPosition({ lat: lat, lng: lng });
    } else {
      marker = new google.maps.Marker({
        position: { lat: lat, lng: lng },
        map: map
      });
    }

    fillAddressFields(place);
  });

  var mapClickEnabled = false;

  document.getElementById('map-click-checkbox').addEventListener('change', function () {
    mapClickEnabled = this.checked;
  });

  google.maps.event.addListener(map, 'click', function (event) {
    if (!mapClickEnabled) {
      return;
    }

    var lat = event.latLng.lat();
    var lng = event.latLng.lng();

    document.getElementById('latitude').value = lat;
    document.getElementById('longitude').value = lng;

    if (marker) {
      marker.setPosition(event.latLng);
    } else {
      marker = new google.maps.Marker({
        position: event.latLng,
        map: map
      });
    }

    geocoder.geocode({ 'location': event.latLng }, function (results, status) {
      if (status === 'OK') {
        if (results[0]) {
          fillAddressFields(results[0]);
        }
      }
    });
  });
}

function fillAddressFields(place) {
  var addressComponents = place.address_components;
  var street = '';
  var city = '';
  var state = '';
  var country = '';

  addressComponents.forEach(function (component) {
    var types = component.types;
    if (types.indexOf('street_number') !== -1) {
      street = component.long_name;
    }
    if (types.indexOf('route') !== -1) {
      street += ' ' + component.long_name;
    }
    if (types.indexOf('locality') !== -1) {
      city = component.long_name;
    }
    if (types.indexOf('administrative_area_level_1') !== -1) {
      state = component.long_name;
    }
    if (types.indexOf('country') !== -1) {
      country = component.long_name;
    }
  });

  document.getElementById('street').value = street;
  document.getElementById('city').value = city;
  document.getElementById('state').value = state;
  document.getElementById('country').value = country;
}

function handleLocationError(browserHasGeolocation, pos) {
  var infoWindow = new google.maps.InfoWindow({
    position: pos,
    content: browserHasGeolocation ?
      'Error: The Geolocation service failed.' :
      'Error: Your browser doesn\'t support geolocation.'
  });
  infoWindow.open(map);
}

document.addEventListener('turbo:load', function () {
  if (document.getElementById('map')) {
    initNewPostMap();
  }

  var imagesInput = document.getElementById('images');
  if (imagesInput) {
    imagesInput.addEventListener('change', function (event) {
      const selectedImagesContainer = document.getElementById('selected-images');
      selectedImagesContainer.innerHTML = '';
      Array.from(event.target.files).forEach(file => {
        const reader = new FileReader();
        reader.onload = function (e) {
          const img = document.createElement('img');
          img.src = e.target.result;
          img.classList.add('w-32', 'h-32', 'object-cover', 'mr-2', 'mb-2');
          selectedImagesContainer.appendChild(img);
        };
        reader.readAsDataURL(file);
      });
    });
  }
});

document.addEventListener('DOMContentLoaded', function () {
  if (document.getElementById('map')) {
    initNewPostMap();
  }

  var imagesInput = document.getElementById('images');
  if (imagesInput) {
    imagesInput.addEventListener('change', function (event) {
      const selectedImagesContainer = document.getElementById('selected-images');
      selectedImagesContainer.innerHTML = '';
      Array.from(event.target.files).forEach(file => {
        const reader = new FileReader();
        reader.onload = function (e) {
          const img = document.createElement('img');
          img.src = e.target.result;
          img.classList.add('w-32', 'h-32', 'object-cover', 'mr-2', 'mb-2');
          selectedImagesContainer.appendChild(img);
        };
        reader.readAsDataURL(file);
      });
    });
  }
});
