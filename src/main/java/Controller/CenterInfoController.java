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
        String city = request.getParameter("city");
        String district = request.getParameter("district");
        String category = request.getParameter("category");

        //디폴트값으로 UI상 맨 처음에 있는 서울시 강남구로 골프로 일단 지정
        if (city == null || city.isEmpty()) city = "서울시";
        if (district == null || district.isEmpty()) district = "강남구";
        if (category == null || category.isEmpty()) category = "골프";

        CenterInfoDAO dao = new CenterInfoDAO();
        try {
            List<CenterInfoDto> centerList = dao.getFilteredCenterList(city, district, category);
            request.setAttribute("centerList", centerList);
            request.setAttribute("selectedCity", city);
            request.setAttribute("selectedDistrict", district);
            request.setAttribute("selectedCategory", category);

            RequestDispatcher dispatcher = request.getRequestDispatcher("centerList.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "데이터를 불러오는 중 오류 발생");
        }
    }
}
