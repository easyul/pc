<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
<%-- <link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/bootstrap.min.css">   --%>
<script type="text/javascript" src="${path}/resources/bootstrap/js/jquery.js"></script>
<script type="text/javascript" src="${path}/resources/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="${path}/resources/bootstrap/css/bootstrap(1).css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
function chk() {
	if (!$("input:checked[Name='reserveSeatPosition']").is(":checked")){
		alert("좌석을 한자리 이상 선택하세요");
		return false; 
		}
	if(!frm.endtime.value) {
		alert("시간을 체크하세요")
		return false;
	}
}
$(function() {
		var width = ${pc.seatlow};
		var height = ${pc.seatcol};
		for(var i = 1; i <= width; i++) {
			for(var j = 1; j <= height; j++) {
					$("#seatChoice").append('<label class="seatLabel2 ' + i +'-' + j +'" for="' + i +'-' + j +'">' + i +'-' + j +'</lable>');
					$("#seatChoice").append('<input id="' + i +'-' + j +'" class="seat2" name="reserveSeatPosition" type="checkbox" value="'+ i +'-' + j +'" disabled="disabled"/>');
			}
			$("#seatChoice").append('<br>');
		}
	 	var seatlists = "${seatlists}";
	 	var ss = seatlists.replace('[','');
	 	var sss = ss.replace(']','');
	 	var array = sss.split(',');
	 	for (var s in array) {
			var trim = array[s].trim();
			$("." + trim).addClass('btn');
			$("#" + trim).removeAttr('disabled');	
		}

	 	
	 	
	 	$('.seatLabel2.btn').on('click', function(){
	 		if ($(this).hasClass("active")) { 
				// active class 제거
				if(!$(this).hasClass("reserved")){
					$(this).removeClass("active");
				}
				}
				else {
		    	// active class 추가
		    	if(!$(this).hasClass("reserved")){
					$(this).addClass('active');
		    	}
				}
		});
	
		
	 	// 현재시간 기준 예약 시간 설정
	 	var hour = ${now_hour};
	 	var min = ${now_min};
	 	for (var i = hour; i < 24; i++) {
	 		if(min == 0) {
	 			$('#starttime').append('<option value=' + i + ':00>' + i + ':00');
	 			$('#starttime').append('<option value=' + i + ':30>' + i + ':30');
	 		} else {
	 			$('#starttime').append('<option value=' + i + ':30>' + i + ':30');
	 			$('#starttime').append('<option value=' + (i+1) + ':00>' + (i+1) + ':00');
	 		}
	 	}
	});
jQuery(document).ready(function(){
	   
	   
	   
	  $('#reservetime').change(function(){
	  $('#endtime').empty();
	  var starthour = $('#starttime').val().substring(0,2)
	  var startmin = $('#starttime').val().substring(3,5)
	   if(startmin == '00'){           
	     var endmin = $(this).val()
	   }else{
	   var endmin = parseInt($(this).val())+30;
	   }
	  var endhour = parseInt(starthour)
	  if(endmin>59){
	     endhour = endhour + Math.floor(endmin/60)
	     endmin = endmin%60
	    
	  }
	  if(endhour>=24){
	     endhour = endhour%24
	  }
	  if(endhour<10){
	     endhour = "0"+endhour
	  }
	  if(endmin<10){
	     endmin = "0"+endmin
	  }
	  $('#endtime').append('<option value="'+endhour+":"+endmin+'"/>'+endhour+":"+endmin);
	    });
	   
	   $('#starttime').change(function(){
	        $('#endtime').empty();
	        var starthour = $('#starttime').val().substring(0,2)
	        var startmin = $('#starttime').val().substring(3,5)
	         if(startmin == '00'){           
	           var endmin = $('#reservetime').val()
	         }else{
	         var endmin = parseInt($('#reservetime').val())+30;
	         }
	        var endhour = parseInt(starthour)
	        if(endmin>59){
	           endhour = endhour + Math.floor(endmin/60)
	           endmin = endmin%60
	          
	        }
	        if(endhour>=24){
	           endhour = endhour%24
	        }
	        if(endhour<10){
	           endhour = "0"+endhour
	        }
	        if(endmin<10){
	           endmin = "0"+endmin
	        }
	        $('#endtime').append('<option value="'+endhour+":"+endmin+'"/>'+endhour+":"+endmin);
	          });      
	});
jQuery(document).ready(function() {
	$('#starttime').change(function(){
		$("#seatChoice").empty();
		$.post('starttimeChange.do', "changestarttime=" + $('#starttime').val(),
				function(data) { //rlists
					var width = ${pc.seatlow};
					var height = ${pc.seatcol};
					for(var i = 1; i <= width; i++) {
						for(var j = 1; j <= height; j++) {
								$("#seatChoice").append('<label class="seatLabel2 ' + i +'-' + j +'" for="' + i +'-' + j +'">' + i +'-' + j +'</lable>');
								$("#seatChoice").append('<input id="' + i +'-' + j +'" class="seat2" name="reserveSeatPosition" type="checkbox" value="'+ i +'-' + j +'" disabled="disabled"/>');
						}
						$("#seatChoice").append('<br>');
					}
				 	var seatlists = "${seatlists}";
				 	var ss = seatlists.replace('[','');
				 	var sss = ss.replace(']','');
				 	var array = sss.split(',');
				 	for (var s in array) {
						var trim = array[s].trim();
						$("." + trim).addClass('btn');
						$("#" + trim).removeAttr('disabled');	
					}
		
				 	
				 	
				 	$('.seatLabel2.btn').on('click', function(){
				 		if ($(this).hasClass("active")) { 
							// active class 제거
							if(!$(this).hasClass("reserved")){
								$(this).removeClass("active");
							}
							}
							else {
					    	// active class 추가
					    	if(!$(this).hasClass("reserved")){
								$(this).addClass('active');
					    	}
						}
					});
				 		
				 		if(data != null){ 
				 		var rlists = data;
				 	 	var rr = rlists.replace('[',''); 
				 	 	var rrr = rr.replace(']','');
				 	 	var rarray = rrr.split(',');
				 	 	for (var r in rarray) {
				 			var rtrim = rarray[r].trim();
				 			$("." + rtrim).addClass('reserved');
				 			$("." + rtrim).removeAttr('for');
				 				}  
				 			}
		}
		);
	})
})

$(function() {		
	if(${rlists} != null){ 
	var rlists = "${rlists}";
 	var rr = rlists.replace('[',''); 
 	var rrr = rr.replace(']','');
 	var rarray = rrr.split(',');
 	for (var r in rarray) {
		var rtrim = rarray[r].trim();
		$("." + rtrim).addClass('reserved');
		$("." + rtrim).removeAttr('for');
			}  
		}
}); 
	


</script >

<style type="text/css">
body {
	background-color: #2c3e50;
}

.content_center {
	display: flex;
	justify-content: center;
	position: relative;
}

.total_content {
	width: 90%;
	height: 90%;
	border-radius: 20px;
	background-color: white;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}
#seatChoice input {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: inherit;
	height: inherit;
	margin-bottom: 0;
	z-index: -1;
	opacity: 0;
}

.seatLabel2 {
	font-size: 13px;
	padding: 3px 0;
	width: 40px;
	margin: 2px 2px;
	border: 1px solid rgba(0, 0, 0, 0);
	opacity: 0;
}

.seatLabel2.active{
		background-color: rgba(0, 50, 100, 0.5);
	}

.seatLabel2.btn {
	font-size: 13px;
	padding: 3px 0;
	width: 40px;
	margin: 2px 2px;
	border: 1px solid rgba(0, 0, 0, 0.5);
	opacity: 1;
}
.reserved {
	color: red;
	border-color: red;
}
#starttime {
	margin-right: 30px;
}
.reserveTiem {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 10px 0;
}
.select-boxs {
	display: flex;
	justify-content: center;
	align-items: center;
}
.select-btn {
	margin: 5px 10px;
}
</style>
</head>
<body onload="seatSize2()">
	<div class="content_center">
		<div class="total_content">
			<h3>좌석 예약</h3>
			<form action="reservation.do" name="frm" onsubmit="return chk()">
				<div id="seatChoice"></div>
				
			
				<div class="reserveTiem">
					시작시간 : <select id="starttime" name="starttime"></select>
					종료 시간 : <select id="endtime" name="endtime"></select>
				</div>
				<div class="select-boxs">
					<select name="reservetime" id="reservetime">
						<option>요금 선택</option>
						<option value="${fee.w1000}">1000원  ${fee.w1000 }분</option>
						<option value="${fee.w3000}">3000원  ${fee.w3000 }분</option>
						<option value="${fee.w5000}">5000원  ${fee.w5000 }분</option>
						<option value="${fee.w10000}">10000원  ${fee.w10000 }분</option>
						<option value="${fee.w50000}">50000원  ${fee.w50000 }분</option>
						<option value="${fee.w100000}">100000원  ${fee.w100000 }분</option>
					</select>
					
					<input type="submit" value="예약" class="btn btn-primary btn-sm select-btn">
				</div>
			</form>
		</div>
	</div>
</body>
</html>