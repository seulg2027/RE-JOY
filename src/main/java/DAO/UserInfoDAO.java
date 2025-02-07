package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
							rs.getString("sex").charAt(0));
			} else {
				throw new IllegalArgumentException("찾는 사용자가 없습니다.");
			}
		} finally {
			DBUtil.close(con, pstmt, rs);
		}

		return user;
	}

	public boolean registerUser(UserInfoDto user) throws Exception {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = DBUtil.getConnection();

			pstmt = con.prepareStatement("insert into Users (name, id, pw, age, sex) values (?, ?, ?, ?, ?)");

			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getId());
			pstmt.setString(3, user.getPw());
			pstmt.setInt(4, user.getAge());
			pstmt.setString(5, String.valueOf(user.getSex()));

			int result = pstmt.executeUpdate();

			if (result == 1) {
				return true;
			}
		} finally {
			DBUtil.close(con, pstmt);
		}
		return false;
	}

	public boolean isUserIdExists(String id) throws Exception {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DBUtil.getConnection();

			pstmt = con.prepareStatement("select count(*) from Users where id = ?");

			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next() && rs.getInt(1) > 0) {
				return true;
			}

		} finally {
			DBUtil.close(con, pstmt);
		}
		return false;
	}

}
