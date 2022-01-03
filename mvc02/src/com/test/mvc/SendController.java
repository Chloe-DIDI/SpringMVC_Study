/*==============================
 * SendController.java
 * 
 * 사용자 정의 컨트롤러
 ===============================*/
package com.test.mvc;

import javax.servlet.http.HttpServletRequest;		//웹컨테이너가 물어오는 것! 
import javax.servlet.http.HttpServletResponse;		//웹컨테이너가 물어오는 것!
// - 면접에서 웹컨테이너 뭐 썼냐고 물어보면 톰캣이라고 대답하면 된다

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 의 『Controller』인터페이스를 구현하는 방법을 통해
//사용자 정의 컨트롤러 클래스를 구성한다.

public class SendController implements Controller
{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("/WEB-INF/view/Send.jsp");
		return mav;
		
	}

	
}
