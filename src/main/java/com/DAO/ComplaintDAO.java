package com.DAO;

import java.util.List;

import com.entity.Complaintdtls;


public interface ComplaintDAO {
	public boolean addComplaint(Complaintdtls cm);
	
	public List<Complaintdtls> getAllComplaints();
	
	public Complaintdtls getComplaintById(int id);
	
	public boolean editComplaint(Complaintdtls cme);
	
	public boolean closeComplaint(int id, String action); // Method to close a complaint


}
