package com.DAO;

import java.util.List;

import com.entity.Complaintdtls;


public interface ComplaintDAO {
	public boolean addComplaint(Complaintdtls cm);
	
	public List<Complaintdtls> getAllComplaints();
	
	public Complaintdtls getComplaintById(int id);
	
	public boolean updateComplaint(Complaintdtls cm);


}
