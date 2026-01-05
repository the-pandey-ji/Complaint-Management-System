package com.DAO;

import java.util.List;

import com.entity.Complaintdtls;
import com.entity.User;


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
	
	public List<Complaintdtls> getActiveComplaintsOfUser(long empn);
	
	
	public int getTotalComplaintCountByCategory(String category);
	
	
	public int getOpenComplaintCountByCategory(String category);
	public int getClosedComplaintCountByCategory(String category);
	
	public List<Complaintdtls> getComplaintsPaginated(
	        String category,
	        int startRow,
	        int endRow);
	
	public int getComplaintCountByCategory(String category) ;
	
	public List<Complaintdtls> getComplaintsPaginatedSearch(
	        String category,
	        String search,
	        int startRow,
	        int endRow);
	public int getComplaintCountByCategorySearch(String category, String search);
	
	public List<Complaintdtls> getPendingComplaintsPaginatedSearch(
	        String category,
	        String search,
	        int startRow,
	        int endRow);
	
	public int getPendingComplaintCountByCategorySearch(
	        String category,
	        String search);

	List<User> getAllUsers();

	boolean addUser(User u);

	User getUserByEmpn(long empn);

	boolean updateUser(User u);

	boolean deleteUser(long empn);
	
	
	

}
