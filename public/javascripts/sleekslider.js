document.addEventListener('turbo:load', function() {
	var $prevThumbnail = document.querySelector('.prev > div > img'),
		$prevText = document.querySelector('.prev > div > h3'),
		$prevButn = document.querySelector('.prev'),
		$nextThumbnail = document.querySelector('.next > div > img'),
		$nextText = document.querySelector('.next > div > h3'),
		$nextButn = document.querySelector('.next');
  
	var thumbs, labels, speed;
	var active, next, total, interval;
	var prevClicked = false;
	var sliderClass;
  
	function sleekslider(object) {
	  active = 1;
  
	  sliderClass = document.querySelector('.sleekslider').classList;
  
	  if (object.thumbs !== undefined && object.thumbs !== null) {
		if (object.thumbs.length > 1) {
		  thumbs = object.thumbs;
		  labels = object.labels;
  
		  $prevThumbnail.src = 'images/' + thumbs[thumbs.length - 1];
		  $prevText.textContent = labels[thumbs.length - 1];
  
		  $nextThumbnail.src = 'images/' + thumbs[active];
		  $nextText.textContent = labels[active];
		} else {
		  document.querySelector('.nav-split').style.display = 'none';
		}
	  } else {
		document.querySelector('.nav-split').style.display = 'none';
	  }
  
	  total = document.querySelectorAll('.slide').length;
  
	  if (total > 1) {
		speed = object.speed;
		interval = setInterval(cycleSlides, speed);
	  } else {
		document.querySelector('.pagination').style.display = 'none';
		document.querySelector('.tabs').style.display = 'none';
	  }
	}
  
	function cycleSlides() {
	  next = (active === total) ? 1 : active + 1;
	  animateSlider();
	}
  
	function animateSlider() {
	  var $activeSlide = document.querySelector('.' + sliderClass + ' > .slide.active');
	  var $nextSlide = document.querySelector('.' + sliderClass + ' > .slide:nth-child(' + next + ')');
  
	  document.querySelector('nav.pagination > span.current').classList.remove('current');
	  document.querySelector('nav.pagination > span:nth-child(' + next + ')').classList.add('current');
  
	  document.querySelector('nav.tabs li.current').classList.remove('current');
	  document.querySelector('nav.tabs li:nth-child(' + next + ')').classList.add('current');
  
	  $nextSlide.style.zIndex = 2;
  
	  $activeSlide.style.display = 'none';
	  $activeSlide.style.zIndex = 1;
	  $activeSlide.classList.remove('active');
	  $nextSlide.style.zIndex = 3;
	  $nextSlide.classList.add('active');
  
	  if (thumbs !== undefined && thumbs !== null) {
		if (prevClicked) {
		  var value = next - 2;
		  if (value < 0) {
			value = thumbs.length - 1;
		  }
		  $prevThumbnail.src = 'images/' + thumbs[value];
		  $prevText.textContent = labels[value];
		} else {
		  $prevThumbnail.src = 'images/' + thumbs[active - 1];
		  $prevText.textContent = labels[active - 1];
		}
  
		if (active === (thumbs.length - 1)) {
		  $nextThumbnail.src = 'images/' + thumbs[0];
		  $nextText.textContent = labels[0];
		} else {
		  $nextThumbnail.src = 'images/' + thumbs[next];
		  $nextText.textContent = labels[next];
		}
	  }
  
	  active = next;
	}
  
	$nextButn.addEventListener('click', function(event) {
	  event.preventDefault();
  
	  if (document.querySelector(".sleekslider > .slide").classList.contains("animated")) {
		return false;
	  } else {
		next = (active === total) ? 1 : active + 1;
		animateSlider();
	  }
	});
  
	$nextButn.addEventListener('mouseenter', function(){
	  clearInterval(interval);
	});
  
	$nextButn.addEventListener('mouseleave', function(){
	  interval = setInterval(cycleSlides, speed);
	});
  
	$prevButn.addEventListener('click', function(event) {
	  event.preventDefault();
  
	  if (document.querySelector(".sleekslider > .slide").classList.contains("animated")) {
		return false;
	  } else {
		prevClicked = true;
		next = (active === 1) ? total : active - 1;
		animateSlider();
	  }
	});
  
	$prevButn.addEventListener('mouseenter', function(){
	  clearInterval(interval);
	});
  
	$prevButn.addEventListener('mouseleave', function(){
	  interval = setInterval(cycleSlides, speed);
	});
  
	document.querySelectorAll('nav.pagination > span').forEach(function(span) {
	  span.addEventListener('mouseenter', function(){
		clearInterval(interval);
	  });
  
	  span.addEventListener('mouseleave', function(){
		interval = setInterval(cycleSlides, speed);
	  });
  
	  span.addEventListener('click', function () {
		if (document.querySelector(".sleekslider > .slide").classList.contains("animated")) {
		  return false;
		} else {
		  var clicked = Array.prototype.indexOf.call(this.parentNode.children, this);
		  if (clicked === 0) {
			prevClicked = true;
		  }
  
		  next = clicked + 1;
		  active = clicked;
		  animateSlider();
		}
	  });
	});
  
	document.querySelectorAll('nav.tabs li').forEach(function(li) {
	  li.addEventListener('mouseenter', function(){
		clearInterval(interval);
	  });
  
	  li.addEventListener('mouseleave', function(){
		interval = setInterval(cycleSlides, speed);
	  });
  
	  li.addEventListener('click', function () {
		if (document.querySelector(".sleekslider > .slide").classList.contains("animated")) {
		  return false;
		} else {
		  var clicked = Array.prototype.indexOf.call(this.parentNode.children, this);
		  if (clicked === 0) {
			prevClicked = true;
		  }
		  
		  next = clicked + 1;
		  active = clicked;
		  animateSlider();
		}
	  });
	});
  });
  