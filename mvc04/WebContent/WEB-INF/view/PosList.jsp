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
<title>DepartmentList.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">

</head>
<body>

<div>

	<div>
		<c:import url="EmpMenu.jsp"></c:import>
	</div>
	
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
		
		<h1>[ 직위 관리 ]</h1>
		<hr>
		
		
		<table class="table" id="position">
			<tr>
				<th>번호</th>
				<th>직위명</th>
				<th>최소 기본급</th>
			</tr>
		
			 <c:forEach var="position" items="${position }">
			 <tr>
			 	<td>${position.positionId }</td>
			 	<td>${position.positionName }</td>
			 	<td>${position.minBasicPay }</td>
			 </tr>
			 </c:forEach>
		</table>
	</div>
	
	
	<!-- 회사소개 및 어플리케이션 소개 영역 -->
	<div id="footer">
	
	</div>


</div>

</body>
</html>