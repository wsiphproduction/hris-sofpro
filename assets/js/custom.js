// var scrollable = document.querySelector('aside');
// var ps = new PerfectScrollbar(scrollable, {
//   	suppressScrollX: true
// });

$(document).on('click', '.nav-dropdown span', function(){
	var dropdown = $(this).closest('.nav-dropdown');
	if(dropdown.hasClass('open')){
		dropdown.removeClass('open');
	}else{
		dropdown.addClass('open');
	}
});

$(window).resize(function(){
	var vh = $(window).height();
	    vh = vh - 55;
	$('aside').css({
		height: vh + 'px'
	});
	$('#homeScroll').css({
		height: (vh + 70) + 'px'
	});
});

$(window).on('load', function () {
	//setTimeout(function(){ 
		$('#overlay').fadeOut();
	//}, 200);
});

$('input, :input').attr('autocomplete', 'off');

$(window).scroll(function(){
    if ($(this).scrollTop() > 100) {
        $('.scrollToTop').fadeIn();
    } else {
        $('.scrollToTop').fadeOut();
    }
}); 
$('.scrollToTop').click(function(){
    $('html, body').animate({scrollTop : 0},"slow");
    return false;
});
