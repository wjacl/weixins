/*
 * 公共界面头部使用的js
 */
function setNav(){
		var demosubmenu = $('#demo-submenu');
		if (demosubmenu.length){
			if ($(window).width() < 450){
				demosubmenu.find('a:last').hide();
			} else {
				demosubmenu.find('a:last').show();
			}
		}
		if ($(window).width() < 767){
			$('.navigation-toggle').each(function(){
				$(this).show();
				var target = $(this).attr('data-target');
				$(target).hide();
				setDemoNav();
			});
		} else {
			$('.navigation-toggle').each(function(){
				$(this).hide();
				var target = $(this).attr('data-target');
				$(target).show();
			});
		}
	}
	function setDemoNav(){
		$('.navigation-toggle').each(function(){
			var target = $(this).attr('data-target');
			if (target == '#navbar-demo'){
				if ($(target).is(':visible')){
					$(this).css('margin-bottom', 0);
				} else {
					$(this).css('margin-bottom', '2.3em');
				}
			}
		});
	}
	$(function(){
		setNav();
		$(window).bind('resize', function(){
			setNav();
		});
		$('.navigation-toggle').bind('click', function(){
			var target = $(this).attr('data-target');
			$(target).toggle();
			setDemoNav();
		});
	})