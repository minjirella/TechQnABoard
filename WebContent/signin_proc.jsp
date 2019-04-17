<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();
					
		// 4. 실행준비
		String sql = "select id from member where id = ? and pw = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		
		// 5. 쿼리 실행
		ResultSet rs = stmt.executeQuery(); //select 일때는 이걸씁니다.
		//stmt.executeUpdate(); //insert는 이걸씁니다.
		
		// 6. select로 로그인 결과값 확인
		boolean isOk = false;
		
		if(rs.next()){
			isOk = true;
			session.setAttribute("id", id);
		}
		
		if(isOk) out.println("로그인되었습니다.");
		else out.println("다시 로그인 해주세요.");
		
	} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
	}
	
%>