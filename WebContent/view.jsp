<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.DBManager"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String userId = (String) session.getAttribute("id");
%>
	<p>현재 사용자 : <%=userId%></p>
<%
	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();
		
		// 4/17 여기서 조회수를 추가하기위해서 객체를 하나씩 더 생성합니다.
		String sql2 = "update article set hit=hit+1 where id = ?";
		PreparedStatement stmt2 = con.prepareStatement(sql2);
		stmt2.setString(1, id);
		stmt2.executeUpdate(); 
		
		
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
			String writer = rs.getString("id2");
%>
		<h1> <%=title %> / <%=num %></h1>
		<p><%=content %></p>
		<p><%=hit %></p>
		<p><%=writer%></p>
		<button type="button" onclick="location='update.jsp?id=<%=id%>'">수정</button>
<%
			if (userId.equals(writer)){
				out.println("<button type='button' onclick='del()'>삭제</button>");
			}else out.println("<button type='button' onclick='warn()'>삭제</button>");

%>	
		<!-- TODO 밑에 목록보기를 만들어주고싶다! -->
		
<%
		}
		
	} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
	}
	
%>
		댓글 <input type="text" id="comment" name="comment">
		<button type="button" onclick="writeComment()">작성</button>
<script>
	function del() {
		var isOk = confirm("삭제?");
		if(isOk){
			location = 'delete_proc.jsp?id=<%=id%>';
		}
	}
	
	function warn() {
		alert("권한이 없습니다.");
	}
</script>