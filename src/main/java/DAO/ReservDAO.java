package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import DTO.UserInfoDto;
import util.DBUtil;
import util.PasswordUtil;

public class ReservDAO {
	   public boolean bookSchedule(String userId, int scheduleId) throws Exception {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;

	        try {
	            con = DBUtil.getConnection();

	            // 예약 가능 여부 확인
	            String checkSql = "SELECT is_booked FROM schedules WHERE schedule_id = ?";
	            pstmt = con.prepareStatement(checkSql);
	            pstmt.setInt(1, scheduleId);
	            rs = pstmt.executeQuery();

	            if (rs.next() && "Y".equals(rs.getString("is_booked"))) {
	                return false; // 이미 예약된 시간대
	            }

	            // 예약 상태 업데이트
	            String updateSql = "UPDATE schedules SET is_booked = 'Y' WHERE schedule_id = ?";
	            pstmt = con.prepareStatement(updateSql);
	            pstmt.setInt(1, scheduleId);
	            pstmt.executeUpdate();

	            // 예약 기록 삽입
	            String insertSql = "INSERT INTO reservations (userId, schedule_id) VALUES (?, ?)";
	            pstmt = con.prepareStatement(insertSql);
	            pstmt.setString(1, userId);
	            pstmt.setInt(2, scheduleId);
	            pstmt.executeUpdate();

	            return true;
	        } finally {
	            DBUtil.close(con, pstmt, rs);
	        }
	    }
	}