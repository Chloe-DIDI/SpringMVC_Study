/*====================
  FileManager.java
===================*/

package com.test.util;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletResponse;

public class FileManager
{
	// 파일 다운로드
	// saveFileName : 서버에 저장된 파일 이름
	// originalFileName : 클라이언트가 업로드한 바일 이름
	// path : 서버에 저장된 경로
	// response : 응답 객체
	public static boolean doFileDownload(String saveFileName, String originalFileName, String Path,
			HttpServletResponse response)
	{
		String load_dir = Path + File.separator + saveFileName;

		// 확인
		System.out.println(load_dir);

		try
		{
			if (originalFileName == null || originalFileName.equals(""))
			{
				originalFileName = saveFileName;
			}

			// 시스템에서 해당 인코딩 방식이 지원되지 않을 경우
			// 『UnsupportedEncodingException』 발생
			originalFileName = new String(originalFileName.getBytes("EUC-KR"), "8859_1");

		} catch (UnsupportedEncodingException e)
		{
			System.out.println(e.toString());
		}

		// -- 여기까지 수행하면 경로가 포함되어 있는 파일의 이름 구성 완료 ~!!!

		try
		{
			// 서버의 파일 경로를 얻어와 파일 객체 생성
			File file = new File(load_dir);

			if (file.exists())
			{
				// 바이트 배열 구성 -> 바이트를 받앗다가 바이트를 다시 내보낸다.
				//byte[] readByte = new byte[5242880]; 	// 5*1024*1024
				byte[] readByte = new byte[4096]; 		// 4*1024

				// 응답 관련 컨텐트 타입 및 헤더 구성
				response.setContentType("application/octet-stream");
				response.setHeader("Content-disposition", "attachment;filename=" + originalFileName);

				// 파일 읽어들이기(스트림 활용)
				BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));

				// 응답을 위한 출력 스트림 구성
				OutputStream os = response.getOutputStream();

				int read;
				//while ((read = bis.read(readByte, 0, 5242880)) != -1)
				while ((read = bis.read(readByte, 0, 4096)) != -1)
				{
					// 읽어서 쓰겠다.
					os.write(readByte, 0, read);
				}

				// 리소스 반납
				os.flush();
				os.close();
				bis.close();

				return true;
			}

		} catch (Exception e)
		{
			System.out.println(e.toString());
		}

		return false;

	}
}