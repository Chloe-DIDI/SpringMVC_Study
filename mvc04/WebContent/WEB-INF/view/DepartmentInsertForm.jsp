<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DepartmentInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function()
	{
		$("#submitBtn").click(function()
		{
			// alert("확인");
			
			if($("#departmentName").val()=="")
			{
				$("#err").html("필수 입력 항목이 누락되었습니다.");
				$("#err").css("display", "inline");
				$("#departmentName").focus();
				return;
			}
			
			// alert("확인");
			$("#departmentForm").submit();
			
		});
		
	});
</script>
</head>
<body>


<div>
	<div>
		<c:import url="EmployeeMenu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
		<h1> [ 부서 추가 ]</h1>
		<hr>
		
		<form action="departmentinsert.action" method="post" id="departmentForm">
			<table>
				<tr>
					<th>부서명</th>
					<td>
						<input type="text" id="departmentName" name="departmentName" placeholder="추가할 부서이름">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<br />
						<br />
						<button type="button" class="btn" id="submitBtn"
						style="width:40%">부서 추가</button>
						<button type="button" class="btn" 
						style="width:40%"
						onclick="location.href='departmentlist.action'">부서 리스트</button>
						<br />
						<br />
						<span id="err" style="color: red; font-weight: bold; display: none;"></span>
					</td>
				</tr>
				
			</table>
		</form>
		
	</div>

	<!-- 회사 소개 및 어플리케이션 소개 영역 -->	
	<div id="footer">
	</div>
	
</div>



</body>
</html>