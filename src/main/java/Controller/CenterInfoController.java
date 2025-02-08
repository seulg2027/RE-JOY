package Controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.RequestDispatcher;

import DAO.CenterInfoDAO;
import DTO.CenterInfoDto;

@WebServlet("/center")
public class CenterInfoController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CenterInfoDAO dao = new CenterInfoDAO();
        try {
            List<CenterInfoDto> centerList = dao.getCenterList();  // ✅ 필터 없이 전체 데이터 가져오기
            request.setAttribute("centerList", centerList);

            // ✅ JSP로 데이터 전달하여 화면에 표시
            RequestDispatcher dispatcher = request.getRequestDispatcher("centerList.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "데이터를 불러오는 중 오류 발생");
        }
    }
}
