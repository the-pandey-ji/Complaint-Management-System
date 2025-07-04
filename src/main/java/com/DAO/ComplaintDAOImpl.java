package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.entity.Complaintdtls;


public class ComplaintDAOImpl implements ComplaintDAO {
	
	private Connection conn;

	public ComplaintDAOImpl(Connection conn) {
		this.conn = conn;
	}
	
	

	@Override
	public boolean addComplaint(Complaintdtls cm) {
		
		boolean flag = false;
		try {
			String query = "insert into complaintdtls(id,imagefile,category,title,description,qtrno,compdatetime,username,phone,status,actiontaken,empn) values('8',?,?,?,?,?,sysdate,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, cm.getImage());
			pstmt.setString(2, cm.getCategory());
			pstmt.setString(3, cm.getTitle());
			pstmt.setString(4, cm.getDescription());
			pstmt.setString(5, cm.getQtrno());
			pstmt.setString(6, cm.getUsername());
			pstmt.setString(7, cm.getPhone());
			pstmt.setString(8, cm.getStatus());
			pstmt.setString(9, cm.getAction());
			pstmt.setInt(10, cm.getEmpn());
			
			
		
			
			int i = pstmt.executeUpdate();

			if (i == 1) {
				flag = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}

	// Other methods can be implemented here as needed

}
