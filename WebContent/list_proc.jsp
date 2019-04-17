<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	body {
		text-align:center;
	}
	section {
		margin:10px;
	}
	
	ul{
		padding:0;
	}
	li {
		display:block;
	}
	
	a{
		text-decoration: none;
		color:black;
	}
	
	a:hover{
		color:purple;
	}
</style>
<%
	String pageStr = request.getParameter("page");
	int pageNum = 0;
	try{
		if(pageStr == null) pageNum = 1;	
		else pageNum = Integer.parseInt(pageStr);
	}catch(Exception e){
		pageNum = 1;
	}
	
	//페이지 나누기.
	int startRow = 0;
	int endRow = 0;
	endRow = pageNum*10;
	startRow = endRow-9;
	
	int total = 0;
	int totalPage = 0;
	
	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();
					
		// 4. 실행준비
		String sql = "select * from article order by id desc"+
					"    limit ?, 10";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, startRow - 1);
		// 5. 쿼리 실행
		ResultSet rs = stmt.executeQuery(); //select 일때는 이걸씁니다.
		//stmt.executeUpdate(); //insert는 이걸씁니다.
		
		// totalPage생성
		String sql2 = "select count(*) as total from article";
		PreparedStatement stmt2 = con.prepareStatement(sql2);
		ResultSet rs2 = stmt2.executeQuery();
		
%>
	<ul>
<%
		// 6. select로 로그인 결과값 확인
		while(rs.next()){
			int id = rs.getInt("id");
			String title = rs.getString("title");
			String content = rs.getString("content");
			int hit = rs.getInt("hit");
			String id2 = rs.getString("id2");
			//절대 경로  http://localhost/JSPBoard/view.jsp?id=1
			//상대 경로  view.jsp?id=1
			out.println("<li>");
			out.println("<a href=view.jsp?id=" + id + ">" + id + "/" + title + "/" + id2 + "</a>");
			out.println("</li>");
		}
%>
	</ul>
<%
		if(rs2.next()) total = rs2.getInt("total");
		
		// 페이지번호 뽑기
		if(total % 10 == 0)	totalPage = total / 10;
		else totalPage = total / 10 + 1;
				
		int startPage = 0;
		startPage = (pageNum-1) / 10 * 10 +1;
		int endPage = 0;		
		endPage = startPage + 9;
		
		if(endPage > totalPage) endPage = totalPage;
%>
		<section>
<%
		for(int i=startPage; i<=endPage; i++){
			out.println("<a href=list_proc.jsp?page="+ i + ">"+ i +"</a>");
		}
%>
		</section>
		<section>
		<button type="button" onclick="location='write.jsp'">글쓰기</button>
		</section>
<%
	} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
	}
	
%>