function initNewPostMap() {
  var mapElement = document.getElementById('map');
  if (!mapElement) {
    console.error("Map element not found!");
    return;
  }

  var map = new google.maps.Map(mapElement, {
    center: { lat: -34.397, lng: 150.644 },
    zoom: 15
  });

  var marker;
  var geocoder = new google.maps.Geocoder();
  var autocomplete = new google.maps.places.Autocomplete(document.getElementById('street'));

  autocomplete.addListener('place_changed', function () {
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      return;
    }
    map.setCenter(place.geometry.location);
    map.setZoom(17);

    if (marker) {
      marker.setPosition(place.geometry.location);
    } else {
      marker = new google.maps.Marker({
        position: place.geometry.location,
        map: map
      });
    }

    fillAddressFields(place);
  });

  google.maps.event.addListener(map, 'click', function (event) {
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

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      function (position) {
        var pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };

        map.setCenter(pos);
      },
      function () {
        handleLocationError(true, map.getCenter());
      }
    );
  } else {
    handleLocationError(false, map.getCenter());
  }
}

function fillAddressFields(place) {
  var addressComponents = place.address_components;

  addressComponents.forEach(function (component) {
    var types = component.types;
    if (types.indexOf('street_number') !== -1) {
      document.getElementById('street').value = component.long_name;
    }
    if (types.indexOf('route') !== -1) {
      document.getElementById('street').value += ' ' + component.long_name;
    }
    if (types.indexOf('locality') !== -1) {
      document.getElementById('city').value = component.long_name;
    }
    if (types.indexOf('administrative_area_level_1') !== -1) {
      document.getElementById('state').value = component.long_name;
    }
    if (types.indexOf('country') !== -1) {
      document.getElementById('country').value = component.long_name;
    }
  });
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
