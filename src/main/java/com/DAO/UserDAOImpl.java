package com.DAO;

import java.sql.Connection;

import com.entity.User;

public class UserDAOImpl implements UserDAO{
	
	private Connection conn;

	public UserDAOImpl(Connection conn) {
		super();
		this.conn = conn;
	}

	
	public boolean userRegister(User us) {
		
		try {
			String query = "insert into usermaster(empn,username,qtrno,email,phone,password,usercreationdate,status) values(?,?,?,?,?,?,SYSDATE,'A')";
			java.sql.PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, us.getEmpn());
			pstmt.setString(2, us.getUsername());
			pstmt.setString(3, us.getQtrno());
			pstmt.setString(4, us.getEmail());
			pstmt.setString(5, us.getPhone());
			pstmt.setString(6, us.getPassword());

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
