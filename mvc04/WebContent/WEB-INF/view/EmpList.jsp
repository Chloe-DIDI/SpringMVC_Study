<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  <!-- 포맷에 대한 jstl을 사용할 준비 -->
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EmployeeList.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
</head>
<body>

<!----------------------------------------------------------------------
  EmpList.jsp
  - 직원 리스트 출력 페이지
  - 일반 직원이 이용하는 전용 출력 페이지
  - 입력 / 수정 / 삭제 기능 없음
--------------------------------------------------------------------------->

<div>
	
	<!-- 메뉴 영역 -->
	<div>
		<c:import url="EmpMenu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
		
		<h1>[ 직원 리스트 ]</h1>
		<hr>
		
		<!-- 직원 추가 div 제거 -->
		
		<br><br>
		<table class="table" id="customer">
			<tr>
				<!-- 항목 생략 -->
				<th>번호</th>
				<th>이름</th>
				<th>지역</th>
				<th>부서</th>
				<th>직위</th>
				<th>등급</th>
			</tr>
			 <c:forEach var="employee" items="${employeeList }">
			 <tr>
			 	<td>${employee.employeeId }</td>
			 	<td>${employee.employeeName }</td>
			 	<td>${employee.regionName }</td>
			 	<td>${employee.departmentName }</td>
			 	<td>${employee.positionName }</td>
			 	<td>${employee.grade==0 ? "관리자" : "일반사원" }</td>
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














