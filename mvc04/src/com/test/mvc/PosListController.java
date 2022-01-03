/*=======================
  PosListController.java
  - 사용자 정의 컨트롤러
========================*/

package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class PosListController implements Controller
{
	private IPositionDAO dao;

	public void setDao(IPositionDAO dao)
	{
		this.dao = dao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		// 세션 처리에 따른 추가 구성 ----------------------------------------------------------------------------
		// 로그인 여부만 확인 → 관리자인지 확인할 필요 없음
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute("name")==null)		//-- 로그인 하지 못한 상황
		{
			mav.setViewName("redirect:loginform.action");
			return mav;
		}
		
		//----------------------------------------------------------------------------- 세션 처리에 따른 추가 구성 
		
		ArrayList<Position> position = new ArrayList<Position>();
		
		try
		{
			position = dao.list();
			
			mav.addObject("position", position);
			
			mav.setViewName("/WEB-INF/view/PosList.jsp");
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return mav;
		
	}

}
