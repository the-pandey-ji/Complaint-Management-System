package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.Complaintdtls;


public class ComplaintDAOImpl implements ComplaintDAO {
	
	private Connection conn;

	public ComplaintDAOImpl(Connection conn) {
		this.conn = conn;
	}
	
	

	public boolean addComplaint(Complaintdtls cm) {
	    boolean flag = false;
	    try {
	        // Query to get the largest id
	        String maxIdQuery = "SELECT MAX(id) FROM complaintdtls";
	        PreparedStatement maxIdStmt = conn.prepareStatement(maxIdQuery);
	        ResultSet rs = maxIdStmt.executeQuery();
	        int newId = 1; // Default to 1 if table is empty

	        if (rs.next()) {
	            newId = rs.getInt(1) + 1; // Increment the largest id by 1
	        }

	        // Insert query with the new id
	        String query = "INSERT INTO complaintdtls(id, imagefile, category, title, description, qtrno, compdatetime, username, phone, status, actiontaken, empn) VALUES(?, ?, ?, ?, ?, ?, SYSDATE, ?, ?, ?, ?, ?)";
	        PreparedStatement pstmt = conn.prepareStatement(query);
	        pstmt.setInt(1, newId); // Set the new id
	        pstmt.setString(2, cm.getImage());
	        pstmt.setString(3, cm.getCategory());
	        pstmt.setString(4, cm.getTitle());
	        pstmt.setString(5, cm.getDescription());
	        pstmt.setString(6, cm.getQtrno());
	        pstmt.setString(7, cm.getUsername());
	        pstmt.setString(8, cm.getPhone());
	        pstmt.setString(9, cm.getStatus());
	        pstmt.setString(10, cm.getAction());
	        pstmt.setInt(11, cm.getEmpn());

	        int i = pstmt.executeUpdate();

	        if (i == 1) {
	            flag = true;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return flag;
	}



	@Override
	public List<Complaintdtls> getAllComplaints() {
		
		// This method should return a list of all complaints from the database
		
		List<Complaintdtls> complaintsList = new ArrayList<Complaintdtls>();
		Complaintdtls complaint = null;
		try {
			String query = "SELECT * FROM complaintdtls";
			PreparedStatement pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				complaint = new Complaintdtls();
				complaint.setid(rs.getInt("id"));
				complaint.setImage(rs.getString("imagefile"));
					complaint.setCategory(rs.getString("category"));
					complaint.setTitle(rs.getString("title"));
					complaint.setDescription(rs.getString("description"));
					complaint.setQtrno(rs.getString("qtrno"));
					complaint.setEmpn(rs.getInt("empn"));
					complaint.setUsername(rs.getString("username"));
					complaint.setPhone(rs.getString("phone"));
					complaint.setCreatedate(rs.getString("compdatetime"));
					complaint.setStatus(rs.getString("status"));
					complaint.setAction(rs.getString("actiontaken"));
					complaintsList.add(complaint);
			}
			

		} catch (Exception e) {
			e.printStackTrace();
		}
		return complaintsList;
	}




}
