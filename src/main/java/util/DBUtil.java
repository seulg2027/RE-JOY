package util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

// DB connection - singleton
public class DBUtil {

	static DataSource ds;

	static {
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env"); //설정 정보 검색 객체
			ds = (DataSource)envContext.lookup("jdbc/fisaDB"); //별칭으로 실제 객체
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	public static Connection getConnection() throws SQLException {
		return ds.getConnection();
	}

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
