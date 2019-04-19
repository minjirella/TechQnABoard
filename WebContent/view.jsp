<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="http://localhost:8080/TechQnABoard/css/common.css" type="text/css">
<link rel="stylesheet" href="http://localhost:8080/TechQnABoard/css/view.css" type="text/css">
    
<%
	String id = request.getParameter("id");
	String userId = (String) session.getAttribute("id");
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
		
		// 4/17 여기서 조회수를 추가하기위해서 객체를 하나씩 더 생성합니다.
		String sql2 = "update article set hit=hit+1 where id = ?";
		PreparedStatement stmt2 = con.prepareStatement(sql2);
		stmt2.setString(1, id);
		stmt2.executeUpdate(); 
		
		
		// 본문의 내용출력
		String sql = "select * from article where id = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery(); //select 일때는 이걸씁니다.
		//stmt.executeUpdate(); //insert는 이걸씁니다.
		
		// 이슈상태를 변경
		// 현재 로그인유저의 부서코드를 뽑아내서,
		// 이슈변경 권한을 부여 --ResultSet은 하단.
		String sqlDeptno = "select deptno from member where id = ?";
		PreparedStatement stmtDeptno = con.prepareStatement(sqlDeptno);
		stmtDeptno.setString(1, userId);
		ResultSet rsDeptno = stmtDeptno.executeQuery();
		
		if(rs.next()){
			String num = rs.getString("id");
			String title = rs.getString("title");
			String content = rs.getString("content");
			int hit = rs.getInt("hit");
			String writer = rs.getString("id2");
%>
		<h3> <%=title %> / <%=num %></h3>
		<p><%=content %></p>
		<p><%=hit %></p>
		<p><%=writer%></p>
		
<%
			if (userId.equals(writer)){
				out.println("<button type='button' onclick='uptContent()'>수정</button>");
				out.println("<button type='button' onclick='del()'>삭제</button>");
			}else {
				out.println("<button type='button' onclick='warn()'>수정</button>");
				out.println("<button type='button' onclick='warn()'>삭제</button>");
			}
		out.println("<button type='button' onclick='listView()'>목록</button>");
		}
		
		// 이슈변경권한 판별
		if(rsDeptno.next()){
			int deptno = rsDeptno.getInt("deptno");
			
			if(deptno != 100){
				out.println("<button type='button' onclick='uptIssue()'>이슈변경</button>");
			}
		}
		
	} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
	}
	
%>
	<section>
		<b>댓	글</b>
		<input type="text" id="comment" name="comment">
		<button type="button" onclick="writeComment()">작성</button>
	</section>
	<article class="commList">
	</article>

<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	function uptContent(){
		location = 'update.jsp?id=<%=id%>';
	}
	
	function listView(){
		location = 'list_proc.jsp';
	}
	
	function uptIssue(){
		location = 'uptIssue.jsp?id=<%=id%>';
	}
	
	function del() {
		var isOk = confirm("삭제?");
		if(isOk){
			location = 'delete_proc.jsp?id=<%=id%>';
		}
	}
	
	function warn() {
		alert("권한이 없습니다.");
	}

	
	function writeComment() {
		$.ajax({
			url: "write_comment.jsp",
			type: "post",
			data: {
				"comment": $("#comment").val(),
				"id": "<%=id%>"
			},
			success: function(res){
				//console.log(res.result)				
				if(res.result > 0){
					$(".commList").load("view_comment.jsp?id=<%=id%>");
					$("#comment").val('');
				}
			}
		})
	}
	
	$(".commList").load("view_comment.jsp?id=<%=id%>");
</script>