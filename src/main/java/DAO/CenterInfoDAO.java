package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import DTO.CenterInfoDto;
import util.DBUtil;

public class CenterInfoDAO {
    private static final Logger logger = LoggerFactory.getLogger(CenterInfoDAO.class);

    public List<CenterInfoDto> getFilteredCenterList(String city, String district, String category) throws Exception {
        List<CenterInfoDto> centerList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT center_id, center_name, spot, category, city, district, center_address, phone, price FROM center_info WHERE 1=1");
        
        if (city != null && !city.isEmpty()) {
            sql.append(" AND city = ?");
        }
        if (district != null && !district.isEmpty()) {
            sql.append(" AND district = ?");
        }
        if (category != null && !category.isEmpty()) {
            sql.append(" AND category = ?");
        }

        try (Connection con = DBUtil.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (city != null && !city.isEmpty()) {
                pstmt.setString(paramIndex++, city);
            }
            if (district != null && !district.isEmpty()) {
                pstmt.setString(paramIndex++, district);
            }
            if (category != null && !category.isEmpty()) {
                pstmt.setString(paramIndex++, category);
            }

            logger.info("Executing query: {}", pstmt.toString());

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    CenterInfoDto center = new CenterInfoDto(
                            rs.getInt("center_id"),
                            rs.getString("center_name"),
                            rs.getString("spot"),
                            rs.getString("category"),
                            rs.getString("city"),
                            rs.getString("district"),
                            rs.getString("center_address"),
                            rs.getString("phone"),
                            rs.getInt("price")
                    );
                    centerList.add(center);
                }
            }
        }
        return centerList;
    }
 // 특정 centerId로 센터 정보를 가져오는 메서드
    public CenterInfoDto getCenterInfoById(int centerId) throws Exception {
    	Connection con = DBUtil.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
        	String sql = "SELECT center_id, center_name, city, district, price FROM center_info WHERE center_id = ?";
            pstmt = con.prepareStatement(sql);
            System.out.println("Fetching Center Info for ID: " + centerId);
            pstmt.setInt(1, centerId);
            System.out.println("Executing query: " + pstmt);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                System.out.println("Data Retrieved: " + rs.getString("center_name"));
            	System.out.println("Data Retrieved: " + rs.getString("center_name"));
                CenterInfoDto centerInfo = new CenterInfoDto();
                centerInfo.setCenter_id(rs.getInt("center_id"));
                centerInfo.setCenter_name(rs.getString("center_name"));
                centerInfo.setCity(rs.getString("city"));
                centerInfo.setDistrict(rs.getString("district"));
                centerInfo.setPrice(rs.getInt("price"));
                return centerInfo;
            } else {
                System.out.println("No data found for Center ID: " + centerId);
                throw new Exception("Center not found for ID: " + centerId);
            }
        } finally {
            DBUtil.close(con, pstmt, rs);
        }
    }
    
}
