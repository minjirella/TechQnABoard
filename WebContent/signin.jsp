<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="http://localhost:8080/TechQnABoard/css/common.css" type="text/css">
<link rel="stylesheet" href="http://localhost:8080/TechQnABoard/css/signin.css" type="text/css">

<h1>로그인</h1>
<form method="post" action="signin_proc.jsp">
	<p>ID : </p>
	<input type="text" name="id">
	<br>
	<p>PW : </p>
	<input type="password" name="pw">
	<br>
	<div id="buttons">
		<input type="submit" value="로그인">
		<input type="reset" value="정정">
		<button type="button" onclick="location='signup.jsp'">회원가입</button>
	</div>
</form>