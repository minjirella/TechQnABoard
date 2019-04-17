<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<form method="post" action="signup_proc.jsp">
	ID : <input type="text" name="id" onblur="move()"><br>
	PW : <input type="password" name="pw"><br>
	이름 : <input type="text" name="name"><br>
	<input type="submit" value="회원가입"><br>
	<input type="reset" value="정정">
</form>

<!-- 아이디를 체크해서 중복여부를 체크하자! -->
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
	function move(){
		$.ajax({ 
			url:"idcheck.jsp",
			type:"get",
			data: { "id" : $('input[name=id]').val() },
			success: function(result){
				$("body").append(result);
				//console.log(result);
			}
		});
	}
</script>