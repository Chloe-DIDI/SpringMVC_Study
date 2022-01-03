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
<title>RegionInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function()
	{
		
		// 지역 추가 버튼이 클릭되었을 때 수행해야 할 코드 처리
		$("#submitBtn").click(function()
		{
			// 데이터 검사(누락된 입력값이 있는지 없는지에 대한 여부 확인)
			if($("#regionName").val()=="" )
			{
				$("#err").html("필수 입력 항목이 누락되었습니다.");
				$("#err").css("display", "inline");
				return;			
				
			}
			
			$("#regionForm").submit();
			
			
		});
	});
</script>
</head>
<body>

<!-------------------------------
    RegionUpdateForm.jsp 
    - 지역 데이터 수정 페이지
---------------------------------->


<div>
	<div>
		<c:import url="EmployeeMenu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
		<h1> [ 지역 수정 ]</h1>
		<hr>
		
		<form action="regionupdate.action" method="post" id="regionForm">
			<table>
				<tr>
					<th>지역 번호</th>
					<td>
						<input type="text" id="regionId" name="regionId" value="${region.regionId }">
					</td>
				</tr>
				<tr>
					<th>지역명</th>
					<td>
						<input type="text" id="regionName" name="regionName" value="${region.regionName }">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<br />
						<br />
						<button type="button" class="btn" id="submitBtn"
						style="width:40%">지역 수정</button>
						<button type="button" class="btn" id="listBtn"
						style="width:40%"
						onclick="location.href='regionlist.action'">지역 리스트</button>
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