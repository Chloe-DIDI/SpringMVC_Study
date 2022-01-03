/*=============================================================
  EmployeeInsertController.java
  - 사용자 정의 컨트롤러
  - 직원 데이터 입력 액션 수행 → DAO 필요
  - 이후 employeelist.action을 다시 요청할수 있도록 안내
  - DAO 객체에 대한 의존성 주입(DI)을 위한 준비
    → 인터페이스 형태의 자료형을 속성으로 구성
    → setter 메소드 구성
==============================================================*/

package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class EmployeeInsertController implements Controller
{
	private IEmployeeDAO dao;

	public void setDao(IEmployeeDAO dao)
	{
		this.dao = dao;
	}


	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 세션 처리에 따른 추가 구성 ----------------------------------------------------------------------------
		// 직접 페이지 요청을 해도 EmployeeList.jsp 페이지에 접근할 수 없도록 구성한다.
		
		// 로그인 여부만 확인 → 관리자인지 확인할 필요 있음!
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute("name")==null)		//-- 로그인 하지 못한 상황
		{
			mav.setViewName("redirect:loginform.action");
			return mav;
		}
		else if(session.getAttribute("admin")==null)	//-- 로그인은 됐는데 관리자가 아닌 상황 
		{
			mav.setViewName("redirect:logout.action");
			return mav;
			//-- 로그인은 되어 있지만 이 때 클라이언트는
			//   일반 직원으로 로그인되어있는 상황이므로
			//   로그아웃 액션 처리하여 다시 관리자로 로그인할 수 있도록 처리
		}
		
		//----------------------------------------------------------------------------- 세션 처리에 따른 추가 구성 
				
		
		// 데이터 수신 → EmployeeInsertForm.jsp 로부터..
		String name = request.getParameter("name");
		String ssn1 = request.getParameter("ssn1");
		String ssn2 = request.getParameter("ssn2");
		String birthday = request.getParameter("birthday");
		String lunar = request.getParameter("lunar");
		String telephone = request.getParameter("telephone");
		String regionId = request.getParameter("regionId");
		String departmentId = request.getParameter("departmentId");
		String positionId = request.getParameter("positionId");
		int basicPay = Integer.parseInt(request.getParameter("basicPay"));
		int extraPay = Integer.parseInt(request.getParameter("extraPay"));
		
		try
		{
			Employee employee = new Employee();
			
			employee.setEmployeeName(name);
			employee.setSsn1(ssn1);
			employee.setSsn2(ssn2);
			employee.setBirthday(birthday);
			employee.setLunarName(lunar);
			employee.setTelephone(telephone);
			employee.setRegionId(regionId);
			employee.setDepartmentId(departmentId);
			employee.setPositionId(positionId);
			employee.setBasicPay(basicPay);
			employee.setExtraPay(extraPay);
			
			dao.employeeAdd(employee);
			
			mav.setViewName("redirect:employeelist.action");
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
		
	}

}
