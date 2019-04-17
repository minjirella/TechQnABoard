<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String id = (String) session.getAttribute("id");
	
	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();
					
		// 4. 실행준비
		String sql = "insert into article values (null, ?, ?, 0, ?)";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, title);
		stmt.setString(2, content);
		stmt.setString(3, id);
		
		// 5. 쿼리 실행
		//stmt.executeQuery(); //select 일때는 이걸씁니다.
		int result = stmt.executeUpdate();
		if(result >= 1) {
			out.println("작성이 완료되었습니다. <br>");
%>
	<a href=list_proc.jsp>목록으로</a>
<%
		}
		else out.println("작성실패");
		
		// 6. select 일경우, 결과값을 저장할 내용 추가.
	} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
	}
	
%>