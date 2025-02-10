package Controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.RequestDispatcher;

import DAO.ReservationDAO;

@WebServlet("/doReservation")
public class DoReservationController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        System.out.println(session);
        int userId = (int) session.getAttribute("sessionId");

        System.out.println("###################" + userId);

        try {
            // 요청 파라미터 가져오기
            int centerId = Integer.parseInt(request.getParameter("center_id"));
            String reservationDate = request.getParameter("reservationDate");
            int reservationTime = Integer.parseInt(request.getParameter("reservationTime"));

            System.out.println("Received Reservation Request: userId=" + userId + ", centerId=" + centerId + ", date=" + reservationDate + ", time=" + reservationTime);

            ReservationDAO reservationDAO = new ReservationDAO();

            // 선택한 날짜, 시간에 해당하는 schedule_id 가져오기
            String scheduleId = reservationDAO.getScheduleId(reservationTime);
            if (scheduleId == null) {
                request.setAttribute("error", "해당 시간에 예약 가능한 스케줄이 없습니다.");
                request.getRequestDispatcher("reservation.jsp").forward(request, response);
                return;
            }

            // 예약 저장
            reservationDAO.bookReservation(userId, centerId, reservationDate, reservationTime);

            // 성공 메시지 전달 후 페이지 이동
            request.setAttribute("success", "예약이 완료되었습니다.");
            // request.getRequestDispatcher("reservationCheck").forward(request, response);
            response.sendRedirect("reservationCheck");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "예약 처리 중 오류가 발생했습니다.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
