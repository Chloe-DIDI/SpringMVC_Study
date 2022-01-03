/*==============================================
 * 			③IMemberDAO.java
 * 			- 인터페이스
 * ============================================*/

package com.test.mybatis;

import java.util.ArrayList;

public interface IMemberDAO
{
	// 메소드 선언 -> add, count, list
	// sql exception 을 throws 하지 않았다 ~! 이전에는 throws 했음!(→ preperstatment 요론거)
	public int add(MemberDTO m);
	public int count();
	public ArrayList<MemberDTO> list();
	public int remove(MemberDTO m);
	public int modify(MemberDTO m);
}
