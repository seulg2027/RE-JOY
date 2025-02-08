package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import DAO.ReservationDAO;
import DTO.ReservationDto;
import Service.UserService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ReservationController
 */
@WebServlet("/reservationCheck")
public class ReservationCheckController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 에약 조회
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId = UserService.checkUserLogin(request, response);
		System.out.println("22222");
		if (userId != null) {
			response.sendRedirect("centerList.jsp");
		}
		ReservationDAO reservationDAO = new ReservationDAO();
		ArrayList<ReservationDto> reservationList;
		System.out.println("11111");
        
		try {
			reservationList = reservationDAO.getReservationList(userId);
			request.setAttribute("reservationList", reservationList);
			request.getRequestDispatcher("reservationCheck.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
