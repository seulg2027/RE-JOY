package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import DTO.UserInfoDto;
import util.DBUtil;
import util.PasswordUtil;
import java.util.ArrayList;
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
            String sql = "SELECT C.center_id, C.center_name, C.center_address, C.price, S.schedule_date, S.start_time, S.end_time\n" +
                        "FROM Reservation R\n" +
                        "\tINNER JOIN Users U\n" +
                        "\tON U.user_id = R.user_id\n" +
                        "\tINNER JOIN Schedules S\n" +
                        "\tON S.schedule_id = R.schedule_id\n" +
                        "\tINNER JOIN center_info C\n" +
                        "\tON C.center_id = R.center_id\n" +
                        "WHERE U.id = ? ORDER BY reservation_time DESC";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            logger.info("Executing query: {}", sql);

            while (rs.next()) {
                ScheduleWithCenterDto reservation = new ScheduleWithCenterDto(
                        rs.getInt("center_id"),
                        rs.getString("center_name"),
                        rs.getString("center_address"),
                        rs.getInt("price"),
                        rs.getDate("schedule_date"),
                        rs.getInt("start_time"),
                        rs.getInt("end_time")
                );
                reservationAll.add(reservation);
            }
        } finally {
            DBUtil.close(con, pstmt, rs);
        }

        return reservationAll;
    }
}
