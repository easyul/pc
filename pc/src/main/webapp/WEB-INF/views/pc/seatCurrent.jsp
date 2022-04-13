<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="../header.jsp"%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어데 피씹니까?</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(function seatSize2() {
	var width = ${pc.seatlow};
	var height = ${pc.seatcol};
	for(var i = 1; i <= width; i++) {
		for(var j = 1; j <= height; j++) {
				$("#seatCurrent").append('<span class="seatSpan ' + i +'-' + j +'">' + i +'-' + j +'</div>');
		}
		$("#seatCurrent").append('<br>');
	}
 	var seatlists = "${seatlists}";
 	var ss = seatlists.replace('[','');
 	var sss = ss.replace(']','');
 	var array = sss.split(',');
 	for (var s in array) {
		var trim = array[s].trim();
		$("." + trim).addClass('nemo');
	}
 	
 	var rlists = "${rlists}";
 	var rr = rlists.replace('[','');
 	var rrr = rr.replace(']','');
 	var rarray = rrr.split(',');
 	for (var r in rarray) {
		var rtrim = rarray[r].trim();
		$("." + rtrim).addClass('reserved');
	}
 	
});
</script>
<style type="text/css">

.seatSpan {
	font-size: 13px;
	padding: 3px 0;
	width: 40px;
	margin: 2px 2px;
	border: 1px solid rgba(0, 0, 0, 0);
	opacity: 0;
}


.seatSpan.nemo {
	font-size: 30px;
	padding: 3px 0;
	width: 100px;
	margin: 2px 2px;
	border: 1px solid rgba(0, 0, 0, 0.5);
	opacity: 1;
}

.seatSpan.reserved {
	color: red;
	border-color: red;
}
</style>
</head>
<body>
<div id="seatCurrent"></div>
</body>
</html>