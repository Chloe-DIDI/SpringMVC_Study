/*=====================================
   MemberInsertController.java
   - 사용자 정의 컨트롤러
   - 회원 데이터 추가 액션 처리 클래스
   - DAO 객체에 대한 의존성 주입 준비
     → setter 메소드 추가
======================================*/

package com.test.mvc;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// 『implements Controller』 혹은 『extends AbstractController』
//-- 서블릿에서 HttpServlet 을 상속받은 서블릿 객체 역할
public class MemberInsertController implements Controller
{
   // ③ dao 관련 속성 구성 → 인터페이스 형태(IMemberDAO 가 인터페이스 형태)
   private IMemberDAO dao;
   
   // △ 위에까지 작성하고 source 로 가서 set 만 구성하면됨!
   // setter 구성
   public void setDao(IMemberDAO dao)
   {
      this.dao = dao;
   }

   @Override
   public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
   {   
      ModelAndView mav = new ModelAndView();
      
      /// ② 캐릭터 인코딩 설정
      request.setCharacterEncoding("UTF-8");
      
      // ① 이전 페이지로부터 넘어온 데이터 수신
      String name = request.getParameter("name");
      String tel = request.getParameter("telephone");
      

      try
      {
         MemberDTO member = new MemberDTO();
         member.setName(name);
         member.setTelephone(tel);
         
         dao.add(member);
         
      } catch (Exception e)
      {
         System.out.println(e.toString());
      }
      
      //④ sendRedirect() ▼ 뷰를 주는게아니라 다시 컨트롤러를 주는 것
      mav.setViewName("redirect:memberlist.action");
      
      
      //▽ 이건안됨 그냥 뷰를 지정하고 뷰한테 아무것도 주지않은 것,,
      //mav.setViewName("/WEB-INF/view/MemberList.jsp"); 
      // 클라이언트는 얘를 만나긴하겟지만 문제가 있다.
      // 이 컨트롤러는 주지 않는다.
      //@ -> 어쨌든 이건 틀린 거! 인원수, 목록을 못 받아 옴
      //@ 뷰를 지정만 하고, 뷰에게 아무거도 안 줌. 카운트 받아서 뿌려 줘.... 이걸 받지 못함. 컨트롤러가 이거 주지 않음
      
      
      //@ 컨트롤러를 요청하게끔 안내함. 이 안내에 의해 클라이언트 이런 요청 다시 발생시킴
      
      return mav;
   }
   
}