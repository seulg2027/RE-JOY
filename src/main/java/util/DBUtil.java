package util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//모든 DAO의 모든 메소드의 공통 코드 (재사용)
public class DBUtil {

	static DataSource ds;

	// static -> 단 한번만 실행 보장~!~!
	static {
		try {
			//서버의 설정을 별칭으로 활용가능하게 하는 API
			//lookup : 검색
			//java:/comp/env - 재사용 가능한 자바 객체 의미
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env"); //설정 정보 검색 객체
			ds = (DataSource)envContext.lookup("jdbc/fisaDB"); //별칭으로 실제 객체
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	// Server 내부의 CP 기능 활용해서 Connection 객체 제공
	public static Connection getConnection() throws SQLException {
		return ds.getConnection();
	}

	// DML용 자원반환
	// client에게 알릴 필요가 없는 에러 처리라서 throws가 아닌 try catch
	// client에게 알려야 할 에러라면 throws로 처리하는 것이 타당
	public static void close(Connection conn, Statement stmt) {
		try {
			if (stmt != null) {
				stmt.close();
				stmt = null;
			}

			if (conn != null) {
				conn.close();
				conn = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();

		}
	}

	public static void close(Connection conn, Statement stmt, ResultSet rs) {
		try {
			if (rs != null) {
				rs.close();
				rs = null;
			}

			if (stmt != null) {
				stmt.close();
				stmt = null;
			}

			if (conn != null) {
				conn.close();
				conn = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			
		}
	}
}
