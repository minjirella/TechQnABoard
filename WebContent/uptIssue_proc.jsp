<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String issue = request.getParameter("issue");
	String id = request.getParameter("id");
	
	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();
					
		// 4. 실행준비
		String sql = "update article set ISSUE=? where id=?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, issue);
		stmt.setString(2, id);
		
		// 5. 쿼리 실행
		//stmt.executeQuery(); //select 일때는 이걸씁니다.
		int result = stmt.executeUpdate();
		if(result == 1) out.println("이슈가 변경되었습니다.");
		
		// 6. select 일경우, 결과값을 저장할 내용 추가.
%>
		<br>
		<a href=view.jsp?id=<%=id %>>이전화면</a><br>
		<a href=list_proc.jsp>목록으로</a>
<%
	} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
	}
	
%>