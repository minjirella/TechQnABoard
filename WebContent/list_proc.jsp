<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<!-- jQuery library -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="http://localhost:8080/TechQnABoard/css/common.css" type="text/css">
<link rel="stylesheet" href="http://localhost:8080/TechQnABoard/css/list_proc.css" type="text/css">

<%
	String userId = (String) session.getAttribute("id");
	String pageStr = request.getParameter("page");
	int pageNum = 0;
	try{
		if(pageStr == null) pageNum = 1;	
		else pageNum = Integer.parseInt(pageStr);
	}catch(Exception e){
		pageNum = 1;
	}
	if(userId==null){
		out.println("<script>");
		out.println("alert('로그인이 필요합니다. 로그인화면으로 이동합니다.');");
		out.println("location.href = 'signin.jsp';");
		out.println("</script>");
	}
	
	//페이지 나누기.
	int startRow = 0;
	int endRow = 0;
	endRow = pageNum*10;
	startRow = endRow-9;
	
	int total = 0;
	int totalPage = 0;
%>
	<h1 id="mainTitle">Issue Tracker</h1>
	<header class="header">
		<p>현재 사용자 : <%=userId%></p>
		<button type="button" onclick="location='signin.jsp'">로그인</button>
		<button type="button" onclick="location='signup.jsp'">회원가입</button>
		<button type="button" onclick="location='logout.jsp'">로그아웃</button>
	</header>

<%
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
		<div class="card" id="card">
			<div class="card-header">
				<p class="card-text">번호</p>
 		    	<p class="card-title"><b>제목</b></p>
 		    	<p class="card-writer">작성자</p>
 		    	<p class="card-issue">이슈상태/보기</p> 		    	
			</div>
<%
		// 6. select로 로그인 결과값 확인
		while (rs.next()) {
			int id = rs.getInt("id");
			String title = rs.getString("title");
			String content = rs.getString("content");
			int hit = rs.getInt("hit");
			String id2 = rs.getString("id2");
			String issue = rs.getString("issue");
			//절대 경로  http://localhost/JSPBoard/view.jsp?id=1
			//상대 경로  view.jsp?id=1
%>
			<div class="card-body">
				<p class="card-text"><%=id%></p>
 		    	<p class="card-title"><b><%=title%></b></p>
 		    	<p class="card-writer"><%=id2%></p>
<%
			if(issue.equals("TODO")){
				out.println("<a href='view.jsp?id="+ id +"' class='card-btn todo'>");
				out.println("신규 이슈</a>");
			}else if(issue.equals("INPROGRESS")){
				out.println("<a href='view.jsp?id="+ id +"' class='card-btn inprogress'>");
				out.println("진행중 이슈</a>");
			}else if(issue.equals("UPGRADE")){
				out.println("<a href='view.jsp?id="+ id +"' class='card-btn upgrade'>");
				out.println("기능개발필요</a>");
			}else{
				out.println("<a href='view.jsp?id="+ id +"' class='card-btn complete'>");
				out.println("해결된 이슈</a>");
			}
			out.println("</div>");
		}
%>
		</div>
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
	<ul id="pagination">
<%
		for(int i=startPage; i<=endPage; i++){
			if(pageNum == i){
%>
				<li class="page-item active"><a class="page-link"
					href="list_proc.jsp?page=<%=i%>"><%=i%></a></li>
<%
				continue;
			}
%>
			<li class="page-item"><a class="page-link"
				href="list_proc.jsp?page=<%=i%>"><%=i%></a></li>
<%
		}
%>
	</ul>
		<section>
		<button type="button" onclick="location='write.jsp'">이슈등록</button>
		</section>
<%
	} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
	}	
%>
