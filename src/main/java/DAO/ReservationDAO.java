package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import DTO.UserInfoDto;
import util.DBUtil;
import util.PasswordUtil;
import java.util.ArrayList;

import DTO.ReservationDto;
import util.DBUtil;

public class ReservationDAO {
	
	public ArrayList<ReservationDto> getReservationList(String id) throws Exception {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<ReservationDto> reservationList = new ArrayList<>();

        try {
            con = DBUtil.getConnection();
            String sql = "SELECT * FROM Reservation WHERE user_id = ? ORDER BY reservation_time DESC";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            while (rs.next()) {
            	ReservationDto reservation = new ReservationDto();
            	reservation.setReservationId(rs.getInt("reservation_id"));
            	reservation.setReservationTime(rs.getDate("reservation_time"));
            	reservation.setScheduleId(rs.getInt("schedule_id"));
            	reservation.setCenterinfoId(rs.getInt("centerinfo_id"));
            	reservation.setUserId(rs.getInt("user_id"));
            	reservationList.add(reservation);
            }
        } finally {
            DBUtil.close(con, pstmt, rs);
        }

        return reservationList;
    }
