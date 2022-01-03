/*======================================================
  #12. PositionDAO.java
   - 데이터베이스 액션 처리 클래스
   - 직위 정보 입력 / 출력 / 수정 / 삭제 액션
   - Connection 객체에 대한 의존성 주입을 위한 준비
   	 → 인터페이스 형태의 속성 구성(Datasource)
   	 → setter 메소드 정의
 ======================================================*/

package com.test.mvc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

public class PositionDAO implements IPositionDAO
{
	private DataSource dataSource;

	// setter 구성
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

	// 직위 전체 리스트
	@Override
	public ArrayList<Position> list() throws SQLException
	{
		ArrayList<Position> result = new ArrayList<Position>();
		
		Connection conn = dataSource.getConnection();
		
		String sql ="SELECT POSITIONID, POSITIONNAME, MINBASICPAY, DELCHECK"
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

	// 직위 데이터 추가
	@Override
	public int add(Position position) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql ="INSERT INTO POSITION(POSITIONID, POSITIONNAME, MINBASICPAY)"
				+ " VALUES(POSITIONSEQ.NEXTVAL, ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, position.getPositionName());
		pstmt.setInt(2, position.getMinBasicPay());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 직위 데이터 삭제
	@Override
	public int remove(String positionId) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql ="DELETE FROM POSITION WHERE POSITIONID=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(positionId));
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 직위 데이터 수정
	@Override
	public int modify(Position position) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql ="UPDATE POSITION"
				+ " SET POSITIONNAME= ?, MINBASICPAY=?"
				+ " WHERE POSITIONID= ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, position.getPositionName());
		pstmt.setInt(2, position.getMinBasicPay());
		pstmt.setInt(3, Integer.parseInt(position.getPositionId()));
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	// 아이디를 통해 이름 얻어내기
	public Position searchId(String positionId) throws SQLException
	{
		Position result = new Position();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT POSITIONID, POSITIONNAME, MINBASICPAY FROM POSITION WHERE POSITIONID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, positionId);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result.setPositionId(rs.getString("POSITIONID"));
			result.setPositionName(rs.getString("POSITIONNAME"));
			result.setMinBasicPay(rs.getInt("MINBASICPAY"));
			
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	

}
