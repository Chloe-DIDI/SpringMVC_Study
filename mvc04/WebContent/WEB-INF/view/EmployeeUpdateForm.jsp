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
<title>EmployeeInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/jquery-ui.css">

<!-- 제이쿼리 쓸 준비!! 
	 https://jqueryui.com/ → 테마 → 갤러리 → 다운로드 
 	 다운받은 것중에 css랑 js, images가져와서 이 프로젝트 webContent에 넣어줌.  
 	 넣어준 거 사용할 수 있게 연결-->

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/jquery-ui.js"></script>
<script type="text/javascript" src="<%=cp %>/js/ajax.js"></script>

<script type="text/javascript">

	//$();		// jquery(); $는 제이쿼리 객체
	$(document).ready(function()
	{
		// Ajax요청 및 응답 처리
		ajaxRequest();
		
		
		// jQuery-UI 캘린더를 불러오는 함수 처리(datapicker)
		$("#birthday").datepicker(
		{
			// 속성명:속성, 속성명:속성
			dateFormat:"yy-mm-dd"
			, changeYear : true
			, changeMonth : true
		});
		
		// 직위(select)의 선택된 내용이 변경되었을 경우 수행해야 할 코드 처리
		$("#positionId").change(function()
		{
			// 테스트
			// alert("변경");
			
			
			// Ajax 요청 및 응답 처리
			ajaxRequest();
			
		});
		
		// 직원 추가 버튼이 클릭되었을 때 수행해야 할 코드 처리
		$("#submitBtn").click(function()
		{
			// 데이터 검사(누락된 입력값이 있는지 없는지에 대한 여부 확인)
			if($("#name").val()=="" || $("#ssn1").val()=="" || $("#ssn2").val()==""
				|| $("#birthday").val()=="" || $("#telephone").val()==""
				|| $("#basicPay").val()=="" )
			{
				$("#err").html("필수 입력 항목이 누락되었습니다.");
				$("#err").css("display", "inline");
				return;			//-- submit 액션 처리 중단
				
			}
			
			// 테스트
			// alert($("#minBasicPay").val());
			//--( X ) 결과 안 나옴...
			// alert($("#minBasicPay").text());
			//--( O ) 이렇게 해야 함!!
			
			
			// 최소 기본급에 대한 유효성 검사
			// if (직급최소급여 > 사용자입력급여)
			
			if ( parseInt($("#minBasicPay").text()) > parseInt($("#basicPay").val()) )
			{
				$("#err").html("입력하신 기본급이 최소 기본급보다 작습니다.");
				$("#err").css("display", "inline");
				return;			//-- submit 액션 처리 중단
			}
			
			
			// 폼 submit 액션 처리 수행
			$("#employeeForm").submit();
			
			
		});
	});
		
		
	
	
	function ajaxRequest()
	{
		// alert("Ajax 요청 및 응답 처리");
		
		// 『$.post()』 / 『$.get()』 제이쿼리 함수
		//-- jquery 에서 Ajax를 써야 할 경우 지원해주는 함수
		//   (서버 측에서 요청한 데이터를 받아오는 기능의 함수)
		
		// ※ 이 함수($.post()) 의 사용방법
		//-- 『$.post(요청주소, 전송데이터, 응답액션처리)』
		//    ㆍ 요청주소(url)
		//       → 데이터를 요청할 파일에 대한 정보
		//    ㆍ전송 데이터(data)
		//      → 서버 측에 요청하는 과정에서 내가 전달할 파라미터
		//    ㆍ응답액션처리(function)
		//      → 응답을 받을 수 있는 함수. 기능처리
		
		// 전송데이터가 여러 속성값일 수 있으므로 제이슨을 사용해서 넘긴다.
		// positionId라는 이름으로 넘길건데, 아이디가 positionId인 것의 속성값을 보낼거야.
		// 받아온 data는 아이디가 minBasicPay인 것의 html에 담아준다.
		
		// ※ 참고로 data는 파라미터의 데이터타입을 그대로 취하게 되므로
		//    html이든, 문자열이든 상관없다.
		$.post("ajax.action", {positionId : $("#positionId").val()}, function(data)
		{
			$("#minBasicPay").html(data);
		});
		
		
	}

</script>
</head>
<body>

<!-------------------------------
    EmployeeUpdateForm.jsp 
    - 직원 데이터 수정 페이지
---------------------------------->

<div>
	<!-- 메뉴 영역 -->
	<div>
		<c:import url="EmployeeMenu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
		<h1> [ 직원 변경 ]</h1>
		<hr>
		
		<form action="employeeupdate.action" method="post" id="employeeForm">
			<table>
				<tr>
					<th>사원번호</th>
					<td>
						<input type="text" id="employeeId" name="employeeId" readonly="readonly"
						value="${employee.employeeId }">
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" id="name" name="name" 
						value="${employee.employeeName }">
					</td>
				</tr>
				<tr>
					<th>주민번호</th>
					<td>
						<input type="text" id="ssn1" name="ssn1" style="width:100px;" 
						value="${employee.ssn1 }">
						<input type="text" id="ssn2" name="ssn2" style="width:110px;" 
						placeholder="뒷 7 자리"><!-- 뒷자리가 패스워드이므로 입력받는다. -->
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>
						<!-- 클릭하면 달력이 보이도록 제이쿼리를 이용해준다. -->
						<input type="text" id="birthday" name="birthday" 
						value="${employee.birthday }">
					</td>
				</tr>
				<tr>
					<th>양/음력</th>
					<td>
						<input type="radio" value="0" name="lunar" id="lunar0" 
						${employee.lunar==0 ? "checked=\"checked\"" : "" }>
						<!-- 루나가 0이면 체크 속성을 준다! 삼항 연산자로 -->
						<label for="lunar0">양력</label>
						<input type="radio" value="1" name="lunar" id="lunar1"
						${employee.lunar==1 ? "checked=\"checked\"" : "" }>
						<label for="lunar1">음력</label>
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="tel" id="telephone" name="telephone" 
						value="${employee.telephone }">
					</td>
				</tr>
				<tr>
					<th>지역</th>
					<td>
						<select id="regionId" name="regionId">
							 <c:forEach var="region" items="${regionList }">
							 	<option value="${region.regionId }" 
							 	${employee.regionId == region.regionId ? "selected=\"selected\"" : "" }>${region.regionName }</option>
							 	<!-- 지역을 미리 선택돼있도록 하기 → 해당 직원의 지역이 지역리스트에 있는 지역이면~ -->
							 </c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>부서</th>
					<td>
						<select id="departmentId" name="departmentId" >
							 <c:forEach var="department" items="${departmentList }">
							 	<option value="${department.departmentId }"
							 	${employee.departmentId == department.departmentId ? "selected=\"selected\"" : "" 
							 	}>${department.departmentName }</option>
							 </c:forEach> 
						</select>
					</td>
				</tr>
				<tr>
					<th>직위</th>
					<td>
						<select id="positionId" name="positionId">
							 <c:forEach var="position" items="${positionList }">
							 	<option value="${position.positionId }"
							 	${employee.positionId == position.positionId ? "selected=\"selected\"" : "" 
							 	}>${position.positionName }</option>
							 </c:forEach>
							 
						</select>
					</td>
				</tr>
				<tr>
					<th>기본급</th>
					<td>
						<input type="text" id="basicPay" name="basicPay"
						value="${employee.basicPay }">	
						<!-- }와 " 사이에 공백이 있으면 다음 페이지에서 수신해서 형변환할 때 에러난다.
						    숫자로 받아들이지를 못 하게 된다. -->
						(최소 기본급 <span id="minBasicPay"
						style="color: red; font-weight: bold;">0</span>원)
					</td>
				</tr>
				<tr>
					<th>수당</th>
					<td>
						<input type="text" id="extraPay" name="extraPay"
						value="${employee.extraPay }">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<br />
						<br />
						<button type="button" class="btn" id="submitBtn"
						style="width:40%">직원 변경</button>
						<button type="button" class="btn" id="listBtn"
						style="width:40%" 
						onclick="location.href='employeelist.action'">직원 리스트</button>
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