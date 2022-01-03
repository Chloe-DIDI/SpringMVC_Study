/*================================================
  EmployeeUpdateFormController.java
  - 사용자 정의 컨트롤러
  - 직원 데이터 수정 폼 요청에 대한 액션 처리
  - DAO 객체에 대한 의존성 주입(DI)을 위한 준비
    → 인터페이스 형태의 자료형 속성으로 구성
    → setter 메소드 구성
=================================================*/

package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class EmployeeUpdateFormController implements Controller
{
	// check~!!!
	// EmployeeInsertFormController 구성과는 다른 방식으로 처리~!!!
	
	private IEmployeeDAO employeeDAO;
	private IRegionDAO regionDAO;
	private IDepartmentDAO departmentDAO;
	private IPositionDAO positionDAO;
	
	public void setEmployeeDAO(IEmployeeDAO employeeDAO)
	{
		this.employeeDAO = employeeDAO;
	}



	public void setRegionDAO(IRegionDAO regionDAO)
	{
		this.regionDAO = regionDAO;
	}



	public void setDepartmentDAO(IDepartmentDAO departmentDAO)
	{
		this.departmentDAO = departmentDAO;
	}



	public void setPositionDAO(IPositionDAO positionDAO)
	{
		this.positionDAO = positionDAO;
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
		
		
		ArrayList<Region> regionList = new ArrayList<Region>();
		ArrayList<Department> departmentList = new ArrayList<Department>();
		ArrayList<Position> positionList = new ArrayList<Position>();
		
		
		try
		{
			// 데이터 수신... (EmployeeList.jsp로부터 employeeId 수신)
			String employeeId = request.getParameter("employeeId");
			
			Employee employee = new Employee();
			
			employee = employeeDAO.searchId(employeeId);

			regionList = regionDAO.list();
	        departmentList = departmentDAO.list();
	        positionList = positionDAO.list();
	        
	        mav.addObject("employee", employee);
	        mav.addObject("regionList", regionList);
	        mav.addObject("departmentList", departmentList);
	        mav.addObject("positionList", positionList);

	        mav.setViewName("/WEB-INF/view/EmployeeUpdateForm.jsp");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
		
	}

}
