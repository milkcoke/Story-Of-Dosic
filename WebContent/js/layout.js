$(document).ready(function(){

	$(".accordion").each(function(){
		var dl = $(".accordion");
		var allDt = dl.find("dt");
		var allDd = dl.find('dd');
		function closeAll(){
			allDt.addClass("closed");
			allDd.addClass("closed");
		}
		function open(dt,dd){
			dt.removeClass('closed');
			dd.removeClass('closed');
		}

		closeAll();
		allDt.click(function(){
			var dt = $(this);
			var dd = dt.next();
			
			closeAll();
			open(dt,dd);
			
			allDt.css("cursor","pointer");
			dt.css("cursor","default");

		});


	});





});//ready

$(document).ready(function(){

	var interval = 3000; //슬라이드쇼 시간간격
	$(".slideshow").each(function(){
	
		var container = $(this);//현재객체
		var timer;

		function switchImg()
		{
			var imgs = container.find('img');
			var first = imgs.eq(0);
			var second = imgs.eq(1);

			first.appendTo(container).fadeOut(2000);
			second.fadeIn();
		}startTimer();

		function startTimer(){timer=setInterval(switchImg,interval);}
		function stopTimer(){clearInterval(timer);}

		$('img').hover(stopTimer,startTimer);

	});

    //일정표 넣는 부분이다.
	//$("#add_img img").on("click",show_note_form);
	$("#add_note").on("click",push_note); //스케쥴을 추가

	function push_note(){
		var title = $("#note_title").val();
		var date = $("#note_date").val();
		var content = $("#note_content").val();
		var str ="<p>"+title+"<br>"+date+"<br>"+content+"</p><br>";
		//$("#note_form").css("display","none");
		//$("$note_form").hide();
		$("#note").append(str);
	}

	function show_note_form(){
		$("#note_form").css("display","none");
		$("#note_form").addClass("popup");
		change_position($(".popup")); 
		$(window).resize(function(){
			change_position($(".popup"));
		});
		//$("#note_form").("display","block");
		//$("#note_form").show().fadeOut(1000).fadeIn(1000);
		$("#note_form").show("show");
	}

	function change_position(obj){
		//화면 정 중앙에 띄운다.
		var l = ($(window).width()-obj.width())/2;
		var t = ($(window).height()-obj.height())/2;
		obj.css({top:t,left:l});

	}
});//ready
