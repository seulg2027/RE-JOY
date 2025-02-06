package Controller;

import java.io.IOException;

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

/**
 * Servlet implementation class UserLoginController
 */
@Slf4j
@WebServlet("/userLogin")
public class UserLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Logger logger = LoggerFactory.getLogger(UserLoginController.class);

	/**
	 * 로그인하기
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("username");
		String pw = request.getParameter("password");
		UserInfoDAO userInfoDao = new UserInfoDAO();
		
		try {			
			UserInfoDto user = userInfoDao.getUserInfo(id, pw);
			if (user != null) {
				request.setAttribute("userInfo", user);
				response.sendRedirect("main.jsp");
			}
		} catch (Exception e) {
			logger.debug("서버에 문제가 발생했습니다. : {}", e.getMessage());

			response.sendRedirect("error.jsp");
		}
	}

}
