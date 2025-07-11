package com.DAO;

import java.util.List;

import com.entity.Complaintdtls;


public interface ComplaintDAO {
	public boolean addComplaint(Complaintdtls cm);
	
	public List<Complaintdtls> getAllComplaints();
	
	public Complaintdtls getComplaintById(int id);
	
	public boolean editComplaint(Complaintdtls cme);
	
	public boolean closeComplaint(int id, String action); // Method to close a complaint
		
	public List<Complaintdtls> getActiveComplaints();
	
	public List<Complaintdtls> getClosedComplaints();
	
	public List<Complaintdtls> getCivilComplaints();
	
	public List<Complaintdtls> getElectricalComplaints();
	
	public List<Complaintdtls> getUserComplaints(long empn);

	/*
	 * public List<Complaintdtls> getUserComplaintsByStatus(long empn, String
	 * status);
	 */
	public List<Complaintdtls> getUserComplaintsByType(long empn, String type);
	
	public List<Complaintdtls> getUserPreviousOneComplaint(long empn);
	

}
