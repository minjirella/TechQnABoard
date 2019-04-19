<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
%>
<h1 id="mainTitle">이슈 상태 변경</h1>
<form method="post" action="uptIssue_proc.jsp">
	<div id="radioBox">
		<input type="radio" name="issue" value="TODO" checked="checked" />신규 이슈
		<input type="radio" name="issue" value="INPROGRESS"/> 진행중인 이슈
		<input type="radio" name="issue" value="COMPLETE"/> 해결된 이슈
		<input type="radio" name="issue" value="UPGRADE"/> 기능개발필요
	</div>
	<div id="buttons">
		<input type="submit" value="이슈변경">
		<input type="hidden" name="id" value="<%=id%>">
	</div>
</form>