<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();
					
		// 4. 실행준비
		String sql = "select * from article where id = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, id);
		
		// 5. 쿼리 실행
		ResultSet rs = stmt.executeQuery(); //select 일때는 이걸씁니다.
		//stmt.executeUpdate(); //insert는 이걸씁니다.
		
		// 6. select로 로그인 결과값 확인
		if(rs.next()){
			String num = rs.getString("id");
			String title = rs.getString("title");
			String content = rs.getString("content");
			int hit = rs.getInt("hit");
			String id2 = rs.getString("id2");
%>

	<form method="post" action="update_proc.jsp">
		제목 : <input type="text" name="title" value="<%=title%>"><br>
		내용 : <textarea name="content"><%=content%></textarea><br>
		<input type="hidden" name="id" value="<%=id%>">
		<input type="submit" value="수정완료"><br>
		<input type="reset" value="정정">
	</form>

<%
		}
	} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
	}
	
%>