package Controller;

import java.io.IOException;
import java.sql.SQLException;  // SQLException 임포트 추가
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import DAO.ReservationDAO;

@WebServlet("/reservationCancel")
public class ReservationCancelController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 폼의 hidden 필드 "reservationId"에서 예약 ID 가져오기
        String reservation_id = request.getParameter("reservation_id");
        System.out.println("Received reservationId: " + reservation_id);
        
        if (reservation_id == null || reservation_id.trim().isEmpty()) {
            request.setAttribute("error", "예약 ID가 제공되지 않았습니다.");
            request.getRequestDispatcher("reservationCheck.jsp").forward(request, response);
            return;
        }
        
        // 문자열을 int로 변환x
        int reservationId = Integer.parseInt(reservation_id);
        
        ReservationDAO reservationDAO = new ReservationDAO();
        boolean success = false;
        
        try {
            // DAO의 cancelReservation 메서드 호출 (SQLException 발생 가능)
            success = reservationDAO.cancelReservation(reservationId);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "예약 취소 처리 중 오류가 발생했습니다.");
            request.getRequestDispatcher("reservationCheck.jsp").forward(request, response);
            return;
        }
        
        if (success) {
            request.setAttribute("message", "예약이 성공적으로 취소되었습니다.");
        } else {
            request.setAttribute("error", "예약 취소에 실패하였습니다. 다시 시도해주세요.");
        }
        
        // 결과 메시지를 포함한 예약 조회 페이지로 포워딩
        request.getRequestDispatcher("reservationCheck.jsp").forward(request, response);
    }
}
