<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8"); %>
<%
	String id = request.getParameter("id");
	String comment = request.getParameter("comment");
	String userId = (String) session.getAttribute("id");
	
	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();

		// 댓글 Insert
		String sql = "insert into comment values (null, ?, ?, ?, now())";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, userId);
		stmt.setString(3, comment);
		int result = stmt.executeUpdate();
		out.println("{\"result\":" + result + "}");
		
		// 6. select 일경우, 결과값을 저장할 내용 추가.
	} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
	}
	
%>