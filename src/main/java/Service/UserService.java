package Service;

import DAO.UserInfoDAO;
import DTO.UserInfoDto;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class UserService {

    public void authenticateUser(HttpServletRequest request, HttpServletResponse response, String id, String pw) throws Exception {
        UserInfoDAO dao = new UserInfoDAO();
        UserInfoDto user = dao.getUserInfo(id, pw);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("sessionId", user.getUserId());
            session.setAttribute("userId", user.getId());
            request.setAttribute("userInfo", user);
            session.setMaxInactiveInterval(60 * 60); // 세션 만료 시간 : 60분
            response.sendRedirect("center");
        } else {
            request.setAttribute("error", "사용자가 없습니다.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    public static String checkUserLogin(HttpServletRequest request, HttpServletResponse response) {
        String userId = null;
    	try {
            userId = (String) request.getSession().getAttribute("userId");
            
            if (userId == null) {
            	return null;
            }
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
		return userId;
    }
}
