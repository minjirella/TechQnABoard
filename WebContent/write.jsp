<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 제목 input Text -->
<!-- 내용 textarea -->
<form method="post" action="write_proc.jsp">
	제목 : <input type="text" name="title"><br>
	내용 : <textarea name="content"></textarea><br>
	<input type="submit" value="작성완료"><br>
	<input type="reset" value="정정">
</form>