package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class UserSignUpController
 */
@WebServlet("/user/signup")
public class UserSignUpController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

        UserInfoDAO userinfoDAO = new UserInfoDAO();

        // 중복 아이디 확인
        try {
			if (userinfoDAO.isUserIdExists(id)) {
			    request.setAttribute("error", "이미 존재하는 아이디입니다.");
			    request.getRequestDispatcher("/signup.jsp").forward(request, response);
			    return;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
        
        // 비밀번호 암호화

        // DTO 생성 후 회원가입 처리
        UserInfoDto user = new UserInfoDto(0, name, id, password, age, gender);
        
        boolean isRegistered = false;
		try {
			isRegistered = userinfoDAO.registerUser(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
        if (isRegistered) {
            response.sendRedirect("main.jsp");
        } else {
            request.setAttribute("error", "회원가입 실패. 다시 시도해주세요.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
        }
    }
}
