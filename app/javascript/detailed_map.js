function initSharedMap() {
  var mapElement = document.getElementById('detailedMap');
  if (!mapElement) {
    console.error("Map element not found!");
    return;
  }

  var posts = JSON.parse(mapElement.dataset.posts);
  var bookings = JSON.parse(mapElement.dataset.bookings);

  var closestBooking = bookings.reduce((closest, booking) => {
    var currentDate = new Date();
    var bookingDate = new Date(booking.start_date);

    if (!closest || (bookingDate >= currentDate && bookingDate < new Date(closest.start_date))) {
      return booking;
    }
    return closest;
  }, null);

  var initialCenter = closestBooking
    ? { lat: closestBooking.post.latitude, lng: closestBooking.post.longitude }
    : { lat: 51.9194, lng: 19.1451 };

  var mapOptions = {
    zoom: 12,
    center: initialCenter
  };

  var map = new google.maps.Map(mapElement, mapOptions);

  var markers = [];

  posts.forEach(function (post) {
    var marker = new google.maps.Marker({
      position: { lat: post.latitude, lng: post.longitude },
      map: map,
      title: post.title
    });

    var infowindow = new google.maps.InfoWindow({
      content: `<h3>${post.title}</h3><p>${post.description}</p>`
    });

    marker.addListener('click', function () {
      infowindow.open(map, marker);
    });

    markers.push(marker);
  });

  bookings.forEach(function (booking) {
    var bookingMarker = new google.maps.Marker({
      position: { lat: booking.post.latitude, lng: booking.post.longitude },
      map: map,
      title: `Booking for ${booking.post.title} (Start: ${new Date(booking.start_date).toLocaleString()})`
    });

    var bookingInfowindow = new google.maps.InfoWindow({
      content: `<h3>Booking for ${booking.post.title}</h3><p>Booked by: ${booking.user.email}</p><p>Start: ${new Date(booking.start_date).toLocaleString()}</p><p>End: ${new Date(booking.end_date).toLocaleString()}</p>`
    });

    bookingMarker.addListener('click', function () {
      bookingInfowindow.open(map, bookingMarker);
    });

    markers.push(bookingMarker);
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

function initializeMapIfNeeded() {
  if (document.getElementById('detailedMap')) {
    initSharedMap();
  }
}

function initializeNavToggle() {
  var navToggle = document.getElementById('nav-toggle');
  var navMenu = document.getElementById('nav-menu');

  if (navToggle && navMenu) {
    navToggle.addEventListener('click', function () {
      navMenu.classList.toggle('hidden');
    });
  }
}

document.addEventListener('turbo:load', function () {
  initializeMapIfNeeded();
  initializeNavToggle();
});

document.addEventListener('DOMContentLoaded', function () {
  initializeMapIfNeeded();
  initializeNavToggle();
});