<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8"); %>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- jQuery library -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="http://localhost:8080/TechQnABoard/css/common.css" type="text/css">

<%
	String id = request.getParameter("id");
	String comment = request.getParameter("comment");
	String userId = (String) session.getAttribute("id");
	
	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();
		// 댓글 목록 출력
%>
		<div class="card">
<%
		String sqlView = "select * from comment where id = ?";
		PreparedStatement pstmt = con.prepareStatement(sqlView);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
			String commWriter = rs.getString("id2");
			String commContent = rs.getString("comm_content");
			String commDate = rs.getString("comm_date");
%>
			<div class="card-body">
		    	<p class="card-title"><%=commWriter%></p>
		    	<p class="card-text"><%=commContent%></p>
		    	<p class="date"><%=commDate%></p>
			</div>
<%
		}
%>
		</div>
<%
		
		// 6. select 일경우, 결과값을 저장할 내용 추가.
	} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
	}
	
%>