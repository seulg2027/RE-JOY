package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import DTO.CenterInfoDto;
import util.DBUtil;

public class CenterInfoDAO {

	public List<CenterInfoDto> getCenterList(String city, String district) throws Exception {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CenterInfoDto> centerList = new ArrayList<>();

		try {
			con = DBUtil.getConnection();
			String sql = "SELECT * FROM center_info WHERE city = ? AND district = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, city);
			pstmt.setString(2, district);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				CenterInfoDto center = new CenterInfoDto();
				center.setCenterId(rs.getInt("centerId"));
				center.setName(rs.getString("name"));
				center.setSpot(rs.getString("spot"));
				center.setCategory(rs.getString("category"));
				center.setCity(rs.getString("city"));
				center.setDistrict(rs.getString("district"));
				center.setPhone(rs.getString("phone"));
				center.setPrice(rs.getString("price"));
				center.setAddress(rs.getString("address"));
				centerList.add(center);
			}
		} finally {
			DBUtil.close(con, pstmt, rs);
		}
		return centerList;
	}
}
