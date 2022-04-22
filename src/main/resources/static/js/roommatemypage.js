$('.roommateSub').owlCarousel({
    responsive:{
        0:{
            items:3
        }
    },
    margin:40,
    loop:false,
    dots:true,
    nav:true,
    navText:
    	['<img src="/image/left-arrows.png" style="width: 21px; margin: 0px 6px;">',
    	
    	'<img src="/image/two-arrows.png" style="width: 21px; margin: 0px 6px;">'],
    navContainer: '#owlCaraouselContainer',
});