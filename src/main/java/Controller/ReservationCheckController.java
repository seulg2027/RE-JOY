package Controller;

import DAO.ReservationDAO;
import DTO.ReservationDTO;
import DTO.ScheduleWithCenterDto;
import Service.UserService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

@WebServlet("/reservationCheck")
public class ReservationCheckController extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(ReservationCheckController.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = UserService.checkUserLogin(request, response);
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        logger.info("user : {}", userId);
        ReservationDAO reservationDAO = new ReservationDAO();

        try {
            List<ScheduleWithCenterDto> reservationList = reservationDAO.getReservationList(userId);
            request.setAttribute("reservationList", reservationList);
            request.getRequestDispatcher("reservationCheck.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}