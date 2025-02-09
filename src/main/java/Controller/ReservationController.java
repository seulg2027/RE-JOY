package Controller;

import java.io.IOException;
import DAO.CenterInfoDAO;
import DTO.CenterInfoDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/reservation")
public class ReservationController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	System.out.println("###############");
        // center_id 파라미터 가져오기
        String centerIdParam = request.getParameter("center_id");
        System.out.println(centerIdParam);
        if (centerIdParam == null || centerIdParam.isEmpty()) {
            response.sendRedirect("error.jsp");
            return;
        }

        int centerId = Integer.parseInt(centerIdParam);
        CenterInfoDAO centerInfoDAO = new CenterInfoDAO();

        try {
            // 선택된 센터 정보 가져오기
            CenterInfoDto centerInfo = centerInfoDAO.getCenterInfoById(centerId);
            if (centerInfo == null) {
                response.sendRedirect("error.jsp");
                return;
            }

            // JSP에 데이터 전달
            request.setAttribute("centerInfo", centerInfo);
            request.getRequestDispatcher("reservation.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "예약 페이지 로딩 중 오류 발생");
        }
    }
}
