/*==============================
 * ReceiveController.java
 * 
 * 사용자 정의 컨트롤러
 ===============================*/
package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class ReceiveController implements Controller
{

   @Override
   public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
   {
      ModelAndView mav = new ModelAndView();
      
      request.setCharacterEncoding("UTF-8");
      String userName = request.getParameter("userName");
      
      mav.addObject("userName",userName);
      mav.setViewName("/WEB-INF/view/Receive.jsp");
      //send.do에서 출발하면 이름을 입력 하고나서 Receive,jsp에서 "안녕하세요. ${userName=김진희}님" 
      
      
      return mav;
   }

   
}