package Controller;

import java.io.IOException;

import DAO.UserInfoDAO;
import DTO.UserInfoDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.PasswordUtil;

@WebServlet("/userSignup")
public class UserSignUpController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 사용자 입력값 받기
        String name = request.getParameter("name");
        String id = request.getParameter("username");
        String password = request.getParameter("password");
        String passwordConfirm = request.getParameter("passwordConfirm");
        int age = Integer.parseInt(request.getParameter("age"));
        char gender = request.getParameter("gender").charAt(0);

        // 유효성 검사
        if (name.isEmpty() || id.isEmpty() || password.isEmpty() || passwordConfirm.isEmpty()) {
            request.setAttribute("message", "모든 필드를 입력해야 합니다.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        if (!password.equals(passwordConfirm)) {
            request.setAttribute("message", "비밀번호가 일치하지 않습니다.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        UserInfoDAO userDAO = new UserInfoDAO();

        // 중복 아이디 확인
        try {
			if (userDAO.isUserIdExists(id)) {
			    request.setAttribute("message", "이미 존재하는 아이디입니다.");
			    request.getRequestDispatcher("/signup.jsp").forward(request, response);
			    return;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

        // 비밀번호 암호화
        String hashedPassword = PasswordUtil.hashPassword(password);
        // DTO 생성 후 회원가입 처리
        
        UserInfoDto user = new UserInfoDto(0, name, id, hashedPassword, age, gender);

        // 회원가입 처리
        boolean isRegistered = false;
		try {
			isRegistered = userDAO.registerUser(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
        if (isRegistered) {
            request.setAttribute("message", "회원가입이 성공적으로 완료되었습니다!");
            request.setAttribute("redirect", "login.jsp");
        } else {
            request.setAttribute("message", "회원가입에 실패했습니다. 다시 시도해주세요.");
            request.setAttribute("redirect", "signup.jsp");
        }

        request.getRequestDispatcher("/signup.jsp").forward(request, response);
        }
    }

