package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import DTO.ReservationDto;
import DTO.ScheduleWithCenterDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import util.DBUtil;

public class ReservationDAO {
	private static final Logger logger = LoggerFactory.getLogger(ReservationDAO.class);

	public ArrayList<ScheduleWithCenterDto> getReservationList(String id) throws Exception {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ScheduleWithCenterDto> reservationAll = new ArrayList<>();

		try {
			con = DBUtil.getConnection();
			String sql = "SELECT C.center_id, C.center_name, C.center_address, C.price, R.reservation_time, S.start_time, S.end_time\n"
					+ "FROM Reservation R\n" + "\tINNER JOIN Users U\n" + "\tON U.user_id = R.user_id\n"
					+ "\tINNER JOIN Schedules S\n" + "\tON S.schedule_id = R.schedule_id\n"
					+ "\tINNER JOIN center_info C\n" + "\tON C.center_id = R.center_id\n"
					+ "WHERE U.id = ? ORDER BY reservation_time DESC";
        System.out.println("Executing SQL: " + sql);
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			logger.info("Executing query: {}", sql);

			while (rs.next()) {
				ScheduleWithCenterDto reservation = new ScheduleWithCenterDto(rs.getInt("center_id"),
						rs.getString("center_name"), rs.getString("center_address"), rs.getInt("price"),
						rs.getDate("reservation_time"), rs.getInt("start_time"), rs.getInt("end_time"));
				reservationAll.add(reservation);
			}
		} finally {
			DBUtil.close(con, pstmt, rs);
		}

		return reservationAll;
	}

    public String getScheduleId(int reservationTime) throws Exception {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String scheduleId = null;

        try {
            con = DBUtil.getConnection();
            String sql = "SELECT schedule_id FROM Schedules WHERE start_time = ?";
            System.out.println("Executing SQL: " + sql);
            
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, reservationTime);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                scheduleId = rs.getString("schedule_id");
            }
        } finally {
            DBUtil.close(con, pstmt, rs);
        }
        System.out.println(scheduleId);
        return scheduleId;
    }

    public void bookReservation(int userId, int centerId, String reservationDate, int reservationTime) throws Exception {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            String scheduleId = getScheduleId(reservationTime);
            if (scheduleId == null) {
                throw new Exception("선택한 시간에 예약 가능한 스케줄이 없습니다.");
            }

            con = DBUtil.getConnection();
            String sql = "INSERT INTO Reservation (user_id, schedule_id, center_id, reservation_time) VALUES (?, ?, ?, ?)";
            System.out.println("Executing SQL: " + sql);

            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setString(2, scheduleId);
            pstmt.setInt(3, centerId);
            pstmt.setString(4, reservationDate);
            pstmt.executeUpdate();
        } finally {
            DBUtil.close(con, pstmt, null);
        }
    }

}