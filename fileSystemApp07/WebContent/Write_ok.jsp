<%-- <%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	/* Write_ok.jsp */
	
	String root = pageContext.getServletContext().getRealPath("/");
	//@ root 경로 자체에 / 들어가 있기 때문에... 사이에 / 넣지 않음
	//String savePath = root + "/" + "pds" + "/" + "saveFile";
	
	//@ "/" = File.separator. 같은 코드임
	//String savePath = root + "pds" + "/" + "saveFile";
	String savePath = root + "pds" + File.separator + "saveFile";
	
	// 경로 확인
	//@ 콘솔 출력
	System.out.println(savePath);
	
	
	// 경로 상 디렉터리가 존재하지 않으면 생성한다.
	File dir = new File(savePath);
	if (!dir.exists())
		dir.mkdirs();
	
	String encType = "UTF-8";
	int maxFileSize = 5*1024*1024;		// 5MB
	
	MultipartRequest req = null;
	String urlFile = "";

	try
	{
		// request, 파일저장경로, 최대크기, 인코딩방식, 중복파일정책
		//@ 4번째거 참조해서 인코딩방식만 중간에 넣어주기!
		req = new MultipartRequest(request, savePath, maxFileSize
									, encType, new DefaultFileRenamePolicy());
		
		out.println("작성자 : " + req.getParameter("userName") + "<br>");
		out.println("제목 : " + req.getParameter("subject") + "<br>");
		out.println("서버에 저장된 파일명 : " + req.getFilesystemName("uploadFile") + "<br>");	
		out.println("파일 타입 : " + req.getContentType("uploadFile") + "<br>" );
		
		File f = req.getFile("uploadFile");
		if (f != null)
		{
			out.println("파일 크기 : " + f.length() + "Bytes. <br>");
		}
		
		urlFile = "Download.jsp?savaFileName=" + req.getFilesystemName("uploadFile");
		urlFile = "&originalFileName" + req.getFilesystemName("uploadFile");
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
	
 	
%>

<br><br><a href="<%=urlFile%>">파일 다운로드</a> --%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<%
   /* Write_ok.jsp */
   
   String root = pageContext.getServletContext().getRealPath("/");
   // String savePath = root + "/" + "pds" + "/" + "saveFile";
   // ▶ root 뒤에 "/"를 포함하고 있기 때문에 위와 같이 "/"를 또 넣지 않는다.
   
   //String savePath = root + "pds" + "/" + "saveFile";
   String savePath = root + "pds" + File.separator + "saveFile";
   // ▶ File.separator 가 "/" 기 때문에 위 두 줄은 같은 코드   
   
   // 경로 확인
   System.out.println(savePath);
   
   // 경로 상 디렉터리가 존재하지 않으면 생성한다.
   File dir = new File(savePath);
   if(!dir.exists())
      dir.mkdirs();
   
   String encType = "UTF-8";
   int maxFileSize = 5*1024*1024;         // 5MB
   
   MultipartRequest req = null;
   String urlFile = "";
   
   try
   {
      // request, 파일저장경로, 최대크기, 인코딩방식, 중복파일명
      req = new MultipartRequest(request, savePath, maxFileSize
                           , encType, new DefaultFileRenamePolicy());
      out.println("작성자 : " + req.getParameter("userName") + "<br>");
      out.println("제목 : " + req.getParameter("subject") + "<br>");
      out.println("서버에 저장된 파일명 : " + req.getFilesystemName("uploadFile") + "<br>");
      out.println("업로드한 실제 파일명 : " + req.getOriginalFileName("uploadFile") + "<br>");
      out.println("파일 타입 : " + req.getContentType("uploadFile") + "<br>");
      
      File f = req.getFile("uploadFile");
      if( f != null)
      {
         out.print("파일 크기 : " + f.length() + "Bytes. <br>");
      }
      
      urlFile = "Download.jsp?saveFileName=" + req.getFilesystemName("uploadFile");
      urlFile += "&originalFileName=" + req.getOriginalFileName("uploadFile");
      
   }
   catch (Exception e)
   {
      System.out.println(e.toString());
   }
%>
<br><br><a href="<%=urlFile%>">파일 다운로드</a>