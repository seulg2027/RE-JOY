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

    public List<CenterInfoDto> getCenterList() throws Exception {
        List<CenterInfoDto> centerList = new ArrayList<>();
        String sql = "SELECT center_id, center_name, spot, category, city, district, center_address, phone, price FROM center_info";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            logger.info("Executing query: {}", sql);

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
                System.out.println(center);
                centerList.add(center);
            }
        } catch (Exception e) {
            logger.error("Error fetching center list", e);
            throw e;  // 예외를 컨트롤러로 전달
        }
        return centerList;
    }
}
