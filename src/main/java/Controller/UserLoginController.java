package Controller;

import java.io.IOException;

import Service.UserService;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import DAO.UserInfoDAO;
import DTO.UserInfoDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import util.SessionUtil;

/**
 * Servlet implementation class UserLoginController
 */
@Slf4j
@WebServlet("/userLogin")
public class UserLoginController extends HttpServlet {
	Logger logger = LoggerFactory.getLogger(UserLoginController.class);
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("error.jsp").forward(request, response);
	}

	/**
	 * 로그인하기
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("username");
		String pw = request.getParameter("password");
		UserService userService = new UserService();
		
		try {
			userService.authenticateUser(request, response, id, pw);
		} catch (Exception e) {
			logger.debug("서버에 문제가 발생했습니다. : {}", e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
}
