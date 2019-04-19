<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="http://localhost:8080/TechQnABoard/css/common.css" type="text/css">
<link rel="stylesheet" href="http://localhost:8080/TechQnABoard/css/signup.css" type="text/css">
    
<h1>회원가입</h1>
<form method="post" action="signup_proc.jsp">
	<p>ID : </p>
	<input type="text" name="id" onblur="move()">
	<p id="idCheck"></p>
	<br>
	<p>PW : </p>
	<input type="password" name="pw">
	<br>
	<p>이름 : </p>
	<input type="text" name="name">
	<br>
	<div id="radioBox">
		<input type="radio" name="deptno" value="100" checked="checked" />고객
		<input type="radio" name="deptno" value="10"/> SW지원부
		<input type="radio" name="deptno" value="20"/> HW지원부
		<input type="radio" name="deptno" value="30"/> 고객지원부
	</div>
	<div id="buttons">
		<input type="submit" value="회원가입">
		<input type="reset" value="정정">
	</div>
</form>

<!-- 아이디를 체크해서 중복여부를 체크하자! -->
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	function move(){
		$.ajax({ 
			url:"idcheck.jsp",
			type:"get",
			data: { "id" : $('input[name=id]').val() },
			success: function(result){
				$("#idCheck").html(result);
				//console.log(result);
			}
		});
	}
</script>