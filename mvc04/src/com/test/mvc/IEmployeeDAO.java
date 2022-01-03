/*============================
  #5. IEmployeeDAO.java
  - 인터페이스
 ============================*/

package com.test.mvc;

import java.sql.SQLException;
import java.util.ArrayList;

public interface IEmployeeDAO
{
	public ArrayList<Employee> list() throws SQLException;
	
	// 회원가입시 옵션으로 보이게 하려고.
	public ArrayList<Region> regionList() throws SQLException;
	public ArrayList<Department> departmentList() throws SQLException;
	public ArrayList<Position> positionList() throws SQLException;
	
	public int getMinBasicPay(String positionId) throws SQLException;
	public int employeeAdd(Employee employee) throws SQLException;
	public int remove(String employeeId) throws SQLException;
	public int modify(Employee employee) throws SQLException;
	public Employee searchId(String employeeId) throws SQLException;	// 아이디를 통해 해당 정보 얻음
	
	public String login(String id, String pw) throws SQLException;		// 결과로 이름이 반환된다.
	public String logAdmin(String id, String pw) throws SQLException;	// 쿼리문에서 처리
	

}
