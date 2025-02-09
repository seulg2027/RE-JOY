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
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userId = UserService.checkUserLogin(request, response);
		if (userId == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// 선택된 centerId 가져오기
        String centerIdParam = request.getParameter("center_id");
        if (centerIdParam == null || centerIdParam.isEmpty()) {
            System.out.println("Error: center_id is missing.");
            response.sendRedirect("error.jsp");
            return;
        }
        int centerId = Integer.parseInt(centerIdParam);

		CenterInfoDAO centerInfoDAO = new CenterInfoDAO();
		ReservationDAO reservationDAO = new ReservationDAO();
		try {
			String reservationDate = request.getParameter("reservationDate");
			String reservationTime = request.getParameter("reservationTime"); 
			// 선택된 센터 정보 가져오기
			CenterInfoDto centerInfo = centerInfoDAO.getCenterInfoById(centerId);
        System.out.println("Center Info Retrieved: " + centerInfo);
        if (centerInfo == null) {
            System.out.println("Error: No center found for ID " + centerId);
            response.sendRedirect("error.jsp");
            return;
        }
			System.out.println("Retrieved Center Info: " + centerInfo);
			// 예약 가능 여부 확인
			boolean isAvailable = reservationDAO.checkAvailability(centerId, reservationDate, reservationTime);
			// 예약 정보와 센터 정보를 저장
			request.setAttribute("centerInfo", centerInfo);
			request.setAttribute("isAvailable", isAvailable);

			request.getRequestDispatcher("reservation.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "예약 처리 중 오류 발생");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    String userIdStr = UserService.checkUserLogin(request, response);
	    if (userIdStr == null) {
	        response.sendRedirect("login.jsp");
	        return;
	    }

	    try {
	        int userId = Integer.parseInt(userIdStr);
        String centerIdParam = request.getParameter("center_id");
        if (centerIdParam == null || centerIdParam.isEmpty()) {
            System.out.println("Error: center_id is missing.");
            response.sendRedirect("error.jsp");
            return;
        }
        int centerId = Integer.parseInt(centerIdParam);
	        String reservationDate = request.getParameter("reservationDate");
	        String reservationTime = request.getParameter("reservationTime"); 

	        ReservationDAO reservationDAO = new ReservationDAO();

	        boolean isAvailable = reservationDAO.checkAvailability(centerId, reservationDate, reservationTime);
	        if (isAvailable) {
	            boolean success = reservationDAO.insertReservation(userId, centerId, reservationDate, reservationTime);
	            if (success) {
	                response.getWriter().write("예약되었습니다!");
	                response.setStatus(HttpServletResponse.SC_OK);
	            } else {
	                response.getWriter().write("예약에 실패했습니다.");
	                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	            }
	        } else {
	            response.getWriter().write("이미 예약된 시간입니다.");
	            response.setStatus(HttpServletResponse.SC_CONFLICT);
	        }
	    } catch (Exception e) {
	        response.getWriter().write("예약 처리 중 오류 발생: " + e.getMessage());
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	    }
	}


}
