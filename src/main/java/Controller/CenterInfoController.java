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
import lombok.extern.slf4j.Slf4j;
import DAO.CenterInfoDAO;
import DTO.CenterInfoDto;

@Slf4j
@WebServlet("/center")
public class CenterInfoController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = LoggerFactory.getLogger(CenterInfoController.class);

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String city = request.getParameter("city");
        String district = request.getParameter("district");
        
        CenterInfoDAO dao = new CenterInfoDAO();
        List<CenterInfoDto> centerList = null;
        
        try {
            centerList = dao.getCenterList(city, district);
            request.setAttribute("centerList", centerList);
            request.getRequestDispatcher("/WEB-INF/views/centerList.jsp").forward(request, response);
        } catch (Exception e) {
            logger.error("Error fetching center list", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "데이터를 불러오는 중 오류 발생");
        }
    }
}
