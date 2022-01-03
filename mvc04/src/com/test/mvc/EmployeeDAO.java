/*==================================================
  #9. EmployeeDAO.java
  - 데이터베이스 액션 처리 클래스
  - 직원 정보 입력 / 출력 / 수정 / 삭제 액션
  - Connection 객체에 대한 의존성 주입을 위한 준비
  	→ 인터페이스 형태의 속성 구성(DataSource)
  	→ setter 메소드 정의
 ==================================================*/

package com.test.mvc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

public class EmployeeDAO implements IEmployeeDAO
{
	// 주요 속성 구성 → 인터페이스 형태
	private DataSource dataSource;
	
	// setter 구성
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	// 직원 리스트 조회
	@Override
	public ArrayList<Employee> list() throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		// result 가 매개변수 이름
		ArrayList<Employee> result = new ArrayList<Employee>();
		
		String sql = "";
		
		sql="SELECT EMPLOYEEID, NAME, SSN, BIRTHDAY"
				+ ", LUNAR, LUNARNAME, TELEPHONE, DEPARTMENTID, DEPARTMENTNAME"
				+ ", POSITIONID, POSITIONNAME, REGIONID, REGIONNAME"
				+ ", BASICPAY, EXTRAPAY, PAY, GRADE"
				+ " FROM EMPLOYEEVIEW"
				+ " ORDER BY EMPLOYEEID";
		
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			Employee employee = new Employee();
			
			employee.setEmployeeId(rs.getString("EMPLOYEEID"));
			employee.setEmployeeName(rs.getString("NAME"));
			employee.setSsn(rs.getString("SSN"));
			employee.setBirthday(rs.getString("BIRTHDAY"));
			employee.setLunar(rs.getInt("LUNAR"));
			employee.setLunarName(rs.getString("LUNARNAME"));
			employee.setTelephone(rs.getString("TELEPHONE"));
			employee.setDepartmentId(rs.getString("DEPARTMENTID"));
			employee.setDepartmentName(rs.getString("DEPARTMENTNAME"));
			employee.setPositionId(rs.getString("POSITIONID"));
			employee.setPositionName(rs.getString("POSITIONNAME"));
			employee.setRegionId(rs.getString("REGIONID"));
			employee.setRegionName(rs.getString("REGIONNAME"));
			employee.setBasicPay(rs.getInt("BASICPAY"));
			employee.setExtraPay(rs.getInt("EXTRAPAY"));
			employee.setPay(rs.getInt("PAY"));
			employee.setGrade(rs.getInt("GRADE"));
			
			result.add(employee);
			
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		// 결과 값에 result 를 넣어줘라..
		return result;
	}

	// 지역 리스트 조회
	@Override
	public ArrayList<Region> regionList() throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<Region> result = new ArrayList<Region>();
		
		String sql = "SELECT REGIONID, REGIONNAME, DELCHECK"
				+ " FROM REGIONVIEW"
				+ " ORDER BY REGIONID";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			Region region = new Region();
			
			region.setRegionId(rs.getString("REGIONID"));
			region.setRegionName(rs.getString("REGIONNAME"));
			region.setDelCheck(rs.getInt("DELCHECK"));
			
			result.add(region);
			
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
		
		
	}

	// 부서 리스트 조회
	@Override
	public ArrayList<Department> departmentList() throws SQLException
	{
		ArrayList<Department> result = new ArrayList<Department>();
		
		Connection conn = dataSource.getConnection();
		
		String sql ="SELECT DEPARTMENTID, DEPARTMENTNAME, DELCHECK"
				+ " FROM DEPARTMENTVIEW"
				+ " ORDER BY DEPARTMENTID";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			Department department = new Department();
			
			department.setDepartmentId(rs.getString("DEPARTMENTID"));
			department.setDepartmentName(rs.getString("DEPARTMENTNAME"));
			department.setDelCheck(rs.getInt("DELCHECK"));
			
			result.add(department);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
		
	}

	//직위 리스트 조회
	@Override
	public ArrayList<Position> positionList() throws SQLException
	{
		ArrayList<Position> result = new ArrayList<Position>();

		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT POSITIONID, POSITIONNAME, MINBASICPAY, DELCHECK"
				+ " FROM POSITIONVIEW"
				+ " ORDER BY POSITIONID";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			Position pos = new Position();
			
			pos.setPositionId(rs.getString("POSITIONID"));
			pos.setPositionName(rs.getString("POSITIONNAME"));
			pos.setMinBasicPay(rs.getInt("MINBASICPAY"));
			pos.setDelCheck(rs.getInt("DELCHECK"));
			
			result.add(pos);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
		
	}
	
	// 직위 아이디에 따른 최소 기본급 확인/검색
	@Override
	public int getMinBasicPay(String positionId) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT MINBASICPAY"
				+ " FROM POSITION"
				+ " WHERE POSITIONID= ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(positionId));			
		// 오라클에서는 1 이런식으로 아이디가 들어가기 때문에 숫자로 변환해주어야 한다.
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result = rs.getInt("MINBASICPAY");
			
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 직원 데이터 추가
	@Override
	public int employeeAdd(Employee employee) throws SQLException
	{
		int result = 0;

		Connection conn = dataSource.getConnection();
		
		String sql = "INSERT INTO EMPLOYEE"
				+ "(EMPLOYEEID, NAME, SSN1, SSN2, BIRTHDAY, LUNAR, TELEPHONE"
				+ ", DEPARTMENTID, POSITIONID, REGIONID, BASICPAY, EXTRAPAY)"
				+ " VALUES(EMPLOYEESEQ.NEXTVAL"
				+ ", ?, ?, CRYPTPACK.ENCRYPT(?, ?)"
				+ ", TO_DATE(?, 'YYYY-MM-DD'), ?, ?"
				+ ", ?, ?, ?, ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, employee.getEmployeeName());
		pstmt.setString(2, employee.getSsn1());
		pstmt.setString(3, employee.getSsn2());
		pstmt.setString(4, employee.getSsn2());
		pstmt.setString(5, employee.getBirthday());
		pstmt.setInt(6, employee.getLunar());
		pstmt.setString(7, employee.getTelephone());
		// pstmt.setString(8, employee.getDepartmentId());  
		// 문자열 정수로 오라클이 변환해줄거지만 우리가 해주는게 더 안정적이지
		pstmt.setInt(8, Integer.parseInt(employee.getDepartmentId()));
		pstmt.setInt(9, Integer.parseInt(employee.getPositionId()));
		pstmt.setInt(10, Integer.parseInt(employee.getRegionId()));
		pstmt.setInt(11, employee.getBasicPay());
		pstmt.setInt(12, employee.getExtraPay());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 직원 데이터 삭제
	@Override
	public int remove(String employeeId) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "DELETE FROM EMPLOYEE WHERE EMPLOYEEID=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(employeeId));
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 직원 데이터 수정
	@Override
	public int modify(Employee employee) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "UPDATE EMPLOYEE"
				+ " SET NAME=?, BIRTHDAY=TO_DATE(?, 'YYYY-MM-DD')"
				+ ", LUNAR=?, TELEPHONE=?"
				+ ", DEPARTMENTID=?, POSITIONID=?, REGIONID=?"
				+ ", BASICPAY=?, EXTRAPAY=?"
				+ ", SSN1=?, SSN2 =CRYPTPACK.ENCRYPT(?,?)"
				+ " WHERE EMPLOYEEID=?";
		
		
		
		// grade 는 수정에서 뺌
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, employee.getEmployeeName());
		pstmt.setString(2, employee.getBirthday());
		pstmt.setInt(3, employee.getLunar());
		pstmt.setString(4, employee.getTelephone());
		pstmt.setInt(5, Integer.parseInt(employee.getDepartmentId()));
		pstmt.setInt(6, Integer.parseInt(employee.getPositionId()));
		pstmt.setInt(7, Integer.parseInt(employee.getRegionId()));
		pstmt.setInt(8, employee.getBasicPay());
		pstmt.setInt(9, employee.getExtraPay());
		pstmt.setString(10, employee.getSsn1());
		pstmt.setString(11, employee.getSsn2());
		pstmt.setString(12, employee.getSsn2());
		pstmt.setInt(13, Integer.parseInt(employee.getEmployeeId()));
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 아이디로 직원 검색
	@Override
	public Employee searchId(String employeeId) throws SQLException
	{
		Employee result = new Employee();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT EMPLOYEEID, NAME, SSN1 "
				+ ", TO_CHAR(BIRTHDAY, 'YYYY-MM-DD') AS BIRTHDAY, LUNAR "
				+ ", TELEPHONE, DEPARTMENTID, POSITIONID, REGIONID "
				+ ", BASICPAY, EXTRAPAY "
				+ " FROM EMPLOYEE"
				+ " WHERE EMPLOYEEID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(employeeId));
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			result.setEmployeeId(rs.getString("EMPLOYEEID"));
			result.setEmployeeName(rs.getString("NAME"));
			result.setSsn1(rs.getString("SSN1"));
			result.setBirthday(rs.getString("BIRTHDAY"));
			result.setLunar(rs.getInt("LUNAR"));
			result.setTelephone(rs.getString("TELEPHONE"));
			result.setDepartmentId(rs.getString("DEPARTMENTID"));
			result.setPositionId(rs.getString("POSITIONID"));
			result.setRegionId(rs.getString("REGIONID"));
			result.setBasicPay(rs.getInt("BASICPAY"));
			result.setExtraPay(rs.getInt("EXTRAPAY"));
			
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 일반 직원 로그인
	@Override
	public String login(String id, String pw) throws SQLException
	{
		String result = null;
		
		Connection conn = dataSource.getConnection();
		
		String sql ="SELECT NAME"
				+ " FROM EMPLOYEE"
				+ " WHERE EMPLOYEEID=?"
				+ " AND SSN2=CRYPTPACK.ENCRYPT(?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(id));
		pstmt.setString(2, pw);
		pstmt.setString(3, pw);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result = rs.getString("NAME");

		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 관리자 로그인
	@Override
	public String logAdmin(String id, String pw) throws SQLException
	{
		String result = null;
		// 이거 꼭 null 이어야 한다. "" 아니고!! 
		// null인지 아닌지로 로그인 조건을 주니까.
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT NAME"
				+ " FROM EMPLOYEE"
				+ " WHERE EMPLOYEEID=?"
				+ " AND SSN2=CRYPTPACK.ENCRYPT(?, ?)"
				+ " AND GRADE=0";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(id));
		pstmt.setInt(2, Integer.parseInt(pw));
		pstmt.setInt(3, Integer.parseInt(pw));
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result = rs.getString("NAME");

		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	

}
