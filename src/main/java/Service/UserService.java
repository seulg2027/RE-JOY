package Service;

import DAO.UserInfoDAO;
import DTO.UserInfoDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class UserService {

    public String authenticateUser(HttpServletRequest request, String id, String pw) throws Exception {
        UserInfoDAO dao = new UserInfoDAO();
        UserInfoDto user = dao.getUserInfo(id, pw);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getId());
            request.setAttribute("userInfo", user);
            session.setMaxInactiveInterval(60 * 60); // 세션 만료 시간 : 60분
            return user.getId();
        }
        return null;
    }
    
    public static String checkUserLogin(HttpServletRequest request, HttpServletResponse response) {
    	try {
        	String userId = (String) request.getSession().getAttribute("userId");
            
            if (userId == null) {
            	return userId;
            }
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
		return null;
    }
}
