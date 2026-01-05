package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.entity.User;

public class UserDAOImpl implements UserDAO{
	
	private Connection conn;

	public UserDAOImpl(Connection conn) {
		super();
		this.conn = conn;
	}

	
	public boolean userRegister(User us) {

	    boolean result = false;

	    try {
	        String sql =
	            "INSERT INTO USERMASTER " +
	            "(EMPN, USERNAME, QTRNO, EMAIL, PHONE, PASSWORD, USERCREATIONDATE, STATUS, ROLE) " +
	            "VALUES (?, ?, ?, ?, ?, ?, SYSDATE, ?, ?)";

	        PreparedStatement ps = conn.prepareStatement(sql);

	        ps.setLong(1, us.getEmpn());
	        ps.setString(2, us.getUsername());
	        ps.setString(3, us.getQtrno());
	        ps.setString(4, us.getEmail());
	        ps.setString(5, us.getPhone());
	        ps.setString(6, us.getPassword());
	        ps.setString(7, us.getStatus()); // A / I
	        ps.setString(8, us.getRole());   // NU / AC / AE

	        result = ps.executeUpdate() == 1;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return result;
	}



	@Override
	public User userLogin(long empn, String password) {
	

		User us = null;
		try {
			String query = "select * from usermaster where empn=? and password=?";
			java.sql.PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setLong(1, empn);
			pstmt.setString(2, password);

			java.sql.ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				us = new User();  
				us.setEmpn(rs.getLong("empn"));
				us.setUsername(rs.getString("username"));
				us.setQtrno(rs.getString("qtrno"));
				us.setEmail(rs.getString("email"));
				us.setPhone(rs.getString("phone"));
				us.setPassword(rs.getString("password"));
				us.setStatus(rs.getString("status"));
				us.setUsercreationdate(rs.getString("usercreationdate"));
				us.setRole(rs.getString("role")); // Assuming you have a role field in User entity
				
				// You can set other fields if needed
				// For example, if you have a field for user creation date or status
				
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return us;
	}
	
	@Override
	public User getUserByEmpn(long empn) {

		User us = null;
		try {
			String query = "select * from usermaster where empn=?";
			java.sql.PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setLong(1, empn);

			java.sql.ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				us = new User();
				us.setEmpn(rs.getLong("empn"));
				us.setUsername(rs.getString("username"));
				us.setQtrno(rs.getString("qtrno"));
				us.setEmail(rs.getString("email"));
				us.setPhone(rs.getString("phone"));
				us.setPassword(rs.getString("password"));
				us.setStatus(rs.getString("status"));
				
				us.setUsercreationdate(rs.getString("usercreationdate"));
				us.setRole(rs.getString("role")); // Assuming you have a role field in User entity
				// You can set other fields if needed
				// For example, if you have a field for user creation date or status

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return us;
	}
	
	@Override
	public boolean updatePassword(long empn, String newPassword) {
		try {
			String query = "update usermaster set password=? where empn=?";
			java.sql.PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, newPassword);
			pstmt.setLong(2, empn);

			int i = pstmt.executeUpdate();

			if (i == 1) {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}
	
	

}
