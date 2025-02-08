package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import jakarta.servlet.annotation.WebServlet;

import DAO.ReservationDAO;

@WebServlet("/reserve")
public class ReservationController extends HttpServlet {
	private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String userId = (String) request.getSession().getAttribute("userId");
	        int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));

	        logger.info("Received reservation request - userId: {}, scheduleId: {}", userId, scheduleId);

	        ReservationDAO dao = new ReservationDAO();
	        try {
	            boolean success = dao.bookSchedule(userId, scheduleId);
	            if (success) {
	                response.sendRedirect("reservationSuccess.jsp");
	            } else {
	                request.setAttribute("errorMessage", "이미 예약된 시간대입니다.");
	                request.getRequestDispatcher("/reservation.jsp").forward(request, response);
	            }
	        } catch (Exception e) {
	            logger.error("Error processing reservation", e);
	            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "예약 처리 중 오류 발생");
	        }
	    }
	} 