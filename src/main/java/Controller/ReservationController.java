package Controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import DAO.CenterInfoDAO;
import DAO.ReservationDAO;
import DTO.CenterInfoDto;
import Service.UserService;
import jakarta.servlet.annotation.WebServlet;


@WebServlet("/reservation")
public class ReservationController extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = UserService.checkUserLogin(request, response);
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 선택된 centerId 가져오기
        int centerId = Integer.parseInt(request.getParameter("center_id"));

        CenterInfoDAO centerInfoDAO = new CenterInfoDAO();
        ReservationDAO reservationDAO = new ReservationDAO();
        try {
        	// 선택된 센터 정보 가져오기
            CenterInfoDto centerInfo = centerInfoDAO.getCenterInfoById(centerId);
            System.out.println("Retrieved Center Info: " + centerInfo);
            // 예약 가능 여부 확인
            boolean isAvailable = reservationDAO.checkAvailability(centerId, request.getParameter("reservationDate"), Integer.parseInt(request.getParameter("startTime")));

            // 예약 정보와 센터 정보를 저장
            request.setAttribute("centerInfo", centerInfo);
            request.setAttribute("isAvailable", isAvailable);
        
  
            request.getRequestDispatcher("reservation.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "예약 처리 중 오류 발생");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = UserService.checkUserLogin(request, response);
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int centerId = Integer.parseInt(request.getParameter("centerId"));
        String reservationDate = request.getParameter("reservationDate");
        int startTime = Integer.parseInt(request.getParameter("startTime"));
        String scheduleId = request.getParameter("scheduleId");

        ReservationDAO reservationDAO = new ReservationDAO();
        try {
            boolean isAvailable = reservationDAO.checkAvailability(centerId, reservationDate, startTime);
            if (isAvailable) {
                reservationDAO.bookReservation(userId, centerId, scheduleId);
                response.getWriter().write("예약되었습니다!");
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.getWriter().write("예약이 차 있습니다.");
                response.setStatus(HttpServletResponse.SC_CONFLICT);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "예약 처리 중 오류 발생");
        }
    }
}

