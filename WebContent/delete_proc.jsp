<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	
	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();
					
		// 4. 실행준비
		String sql = "delete from article where id = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, id);
		
		// 5. 쿼리 실행
		//stmt.executeQuery(); //select 일때는 이걸씁니다.
		int result = stmt.executeUpdate();
		if(result >= 1) {
			response.sendRedirect("list_proc.jsp");
		}
		else out.println("작성실패");
		
		// 6. select 일경우, 결과값을 저장할 내용 추가.
	} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
	}
	
%>