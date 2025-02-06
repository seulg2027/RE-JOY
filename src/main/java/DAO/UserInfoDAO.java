package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DTO.UserInfoDto;
import util.DBUtil;

public class UserInfoDAO {

	public UserInfoDto getUserInfo(String id, String pw) throws Exception {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserInfoDto user = null;
		
		try {
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement("select * from Users where id=? and pw=?");
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				user = new UserInfoDto(
							rs.getInt("user_id"),
							rs.getString("name"),
							rs.getString("id"),
							rs.getString("pw"),
							rs.getInt("age"),
							rs.getString("sex").charAt(0),
							rs.getString("phone"));
			} else {
				throw new IllegalArgumentException("찾는 사용자가 없습니다.");
			}
		} finally {
			DBUtil.close(con, pstmt, rs);
		}

		return user;
	}
}
