<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<%
   /* ObjectRead.jsp */
   /* @@@ 코드 복붙하지 말기! 짧은 시간 내 한번이라도 더 써보기. */
   
   String appRoot = "/";
   appRoot = pageContext.getServletContext().getRealPath(appRoot);
   
   File newFile = new File(appRoot, "objdata/data.ser");
   
   //@ 파일 읽어오기 전에, 해당 디렉토리가 있는지를 항상 먼저 봐야 함!
   // 파일이 해당 경로에 존재하는지 여부 확인(검사)   check~!!!
   if (newFile.exists())
   {
      // 해당 파일을 읽어들이기 위한 FileInputStream 객체 생성
      FileInputStream fis = new FileInputStream(newFile);
      
      // File 에서 Object 를 읽어들이기 위한 ObjectInputStream 객체 생성
      ObjectInputStream ois = new ObjectInputStream(fis);
      
      // ObjectInputStream 을 이용하여 파일로부터 Object를 읽어내기
      Hashtable h = (Hashtable)ois.readObject();
      
      ois.close();
      fis.close();
      
      Enumeration e = h.keys();
      while (e.hasMoreElements())
      {
         String key = (String)e.nextElement();
         String value = (String)h.get(key);
         
%>                  


<%=key %> 의 값은 <%=value %> 입니다. <br>


   
<%         
      }
      
   }
   else
   {
      out.println("해당 파일이 존재하지 않습니다.");
   }
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>