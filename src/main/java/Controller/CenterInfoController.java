package Controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import jakarta.servlet.annotation.WebServlet;
import DAO.CenterInfoDAO;
import DTO.CenterInfoDto;

@WebServlet("/center")
public class CenterInfoController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = LoggerFactory.getLogger(CenterInfoController.class);

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String city = request.getParameter("city");
        String district = request.getParameter("district");

        logger.info("Received request - city: {}, district: {}", city, district);

        CenterInfoDAO dao = new CenterInfoDAO();
        try {
            List<CenterInfoDto> centerList;
            // 파라미터가 없거나 빈 문자열이면 전체 리스트를 조회하도록 (DAO에 전체 조회 메서드가 있다면 사용)
            if (city == null || city.trim().isEmpty() || district == null || district.trim().isEmpty()) {
                centerList = dao.getCenterList(null, null);
            } else {
                centerList = dao.getCenterList(city, district);
            }
            logger.info("Fetched center list: {}", centerList);
            request.setAttribute("centerList", centerList);
            // JSP 파일의 실제 위치에 맞게 경로 수정 (예: /centerList.jsp 또는 /WEB-INF/views/centerList.jsp)
            request.getRequestDispatcher("/centerList.jsp").forward(request, response);
        } catch (Exception e) {
            logger.error("Error fetching center list", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "데이터를 불러오는 중 오류 발생");
        }
    }
}
