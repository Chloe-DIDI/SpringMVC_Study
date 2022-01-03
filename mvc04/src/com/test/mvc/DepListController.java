/*=======================
  DepListController.java
  - 사용자 정의 컨트롤러
========================*/

package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class DepListController implements Controller
{
	private IDepartmentDAO dao;
	
	public void setDao(IDepartmentDAO dao)
	{
		this.dao = dao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 세션 처리에 따른 추가 구성 ----------------------------------------------------------------------------
		// 직접 페이지 요청을 해도 EmpList.jsp 페이지에 접근할 수 없도록 구성한다.
		
		// 로그인 여부만 확인 → 관리자인지 확인할 필요 없음
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute("name")==null)		//-- 로그인 하지 못한 상황
		{
			mav.setViewName("redirect:loginform.action");
			return mav;
		}
		
		//----------------------------------------------------------------------------- 세션 처리에 따른 추가 구성 
		
		ArrayList<Department> departmentList = new ArrayList<Department>();
		
		try
		{
			departmentList  = dao.list();
			
			mav.addObject("departmentList", departmentList);
			
			mav.setViewName("/WEB-INF/view/DepList.jsp");
			
		}
		catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return mav;
		
	}

}
