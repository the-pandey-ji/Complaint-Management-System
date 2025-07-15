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
	        pstmt.setLong(11, cm.getEmpn());

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
			String query = "SELECT * FROM complaintdtls ORDER BY status ASC, id DESC";
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
					complaint.setEmpn(rs.getLong("empn"));
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

	@Override
	public Complaintdtls getComplaintById(int id) {
		Complaintdtls complaint = null;
		try {
			String query = "SELECT * FROM complaintdtls WHERE id=?";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				complaint = new Complaintdtls();
				complaint.setid(rs.getInt("id"));
				complaint.setImage(rs.getString("imagefile"));
				complaint.setCategory(rs.getString("category"));
				complaint.setTitle(rs.getString("title"));
				complaint.setDescription(rs.getString("description"));
				complaint.setQtrno(rs.getString("qtrno"));
				complaint.setEmpn(rs.getLong("empn"));
				complaint.setUsername(rs.getString("username"));
				complaint.setPhone(rs.getString("phone"));
				complaint.setCreatedate(rs.getString("compdatetime"));
				complaint.setStatus(rs.getString("status"));
				complaint.setAction(rs.getString("actiontaken"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return complaint;
	}
	

@Override
public boolean editComplaint(Complaintdtls cme) {
    boolean flag = false;
    try {
        // Update query
        String query = "UPDATE complaintdtls SET imagefile=?, category=?, title=?, description=?, qtrno=?, username=?, phone=?, status=?, actiontaken=?, empn=? WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, cme.getImage());
        pstmt.setString(2, cme.getCategory());
        pstmt.setString(3, cme.getTitle());
        pstmt.setString(4, cme.getDescription());
        pstmt.setString(5, cme.getQtrno());
        pstmt.setString(6, cme.getUsername());
        pstmt.setString(7, cme.getPhone());
        pstmt.setString(8, cme.getStatus());
        pstmt.setString(9, cme.getAction());
        pstmt.setLong(10, cme.getEmpn());
        pstmt.setInt(11, cme.getid());

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
public boolean closeComplaint(int id, String actionTaken) {
    boolean result = false;
    try {
        String query = "UPDATE COMPLAINTDTLS SET status = ?, actiontaken = ? WHERE id = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, "Closed");
        pstmt.setString(2, actionTaken);
        pstmt.setInt(3, id);

        int rows = pstmt.executeUpdate();
        if (rows > 0) {
            result = true;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return result;

}


@Override
public List<Complaintdtls> getActiveComplaints() {
    List<Complaintdtls> activeComplaints = new ArrayList<>();
    try {
        String query = "SELECT * FROM complaintdtls WHERE status='Active' ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(query);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Complaintdtls complaint = new Complaintdtls();
            complaint.setid(rs.getInt("id"));
            complaint.setImage(rs.getString("imagefile"));
            complaint.setCategory(rs.getString("category"));
            complaint.setTitle(rs.getString("title"));
            complaint.setDescription(rs.getString("description"));
            complaint.setQtrno(rs.getString("qtrno"));
            complaint.setEmpn(rs.getLong("empn"));
            complaint.setUsername(rs.getString("username"));
            complaint.setPhone(rs.getString("phone"));
            complaint.setCreatedate(rs.getString("compdatetime"));
            complaint.setStatus(rs.getString("status"));
            complaint.setAction(rs.getString("actiontaken"));
            activeComplaints.add(complaint);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return activeComplaints;
}

@Override
public List<Complaintdtls> getClosedComplaints() {
    List<Complaintdtls> closedComplaints = new ArrayList<>();
    try {
        String query = "SELECT * FROM complaintdtls WHERE status='Closed' ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(query);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Complaintdtls complaint = new Complaintdtls();
            complaint.setid(rs.getInt("id"));
            complaint.setImage(rs.getString("imagefile"));
            complaint.setCategory(rs.getString("category"));
            complaint.setTitle(rs.getString("title"));
            complaint.setDescription(rs.getString("description"));
            complaint.setQtrno(rs.getString("qtrno"));
            complaint.setEmpn(rs.getLong("empn"));
            complaint.setUsername(rs.getString("username"));
            complaint.setPhone(rs.getString("phone"));
            complaint.setCreatedate(rs.getString("compdatetime"));
            complaint.setStatus(rs.getString("status"));
            complaint.setAction(rs.getString("actiontaken"));
            closedComplaints.add(complaint);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return closedComplaints;
}




@Override
public List<Complaintdtls> getCivilComplaints() {
    List<Complaintdtls> civilComplaints = new ArrayList<>();
    try {
        String query = "SELECT * FROM complaintdtls WHERE category='Civil' ORDER BY status ASC, id DESC";
        PreparedStatement pstmt = conn.prepareStatement(query);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Complaintdtls complaint = new Complaintdtls();
            complaint.setid(rs.getInt("id"));
            complaint.setImage(rs.getString("imagefile"));
            complaint.setCategory(rs.getString("category"));
            complaint.setTitle(rs.getString("title"));
            complaint.setDescription(rs.getString("description"));
            complaint.setQtrno(rs.getString("qtrno"));
            complaint.setEmpn(rs.getLong("empn"));
            complaint.setUsername(rs.getString("username"));
            complaint.setPhone(rs.getString("phone"));
            complaint.setCreatedate(rs.getString("compdatetime"));
            complaint.setStatus(rs.getString("status"));
            complaint.setAction(rs.getString("actiontaken"));
            civilComplaints.add(complaint);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return civilComplaints;
}


@Override
public List<Complaintdtls> getElectricalComplaints() {
    List<Complaintdtls> electricalComplaints = new ArrayList<>();
    try {
        String query = "SELECT * FROM complaintdtls WHERE category='Electrical' ORDER BY status ASC, id DESC";
        PreparedStatement pstmt = conn.prepareStatement(query);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Complaintdtls complaint = new Complaintdtls();
            complaint.setid(rs.getInt("id"));
            complaint.setImage(rs.getString("imagefile"));
            complaint.setCategory(rs.getString("category"));
            complaint.setTitle(rs.getString("title"));
            complaint.setDescription(rs.getString("description"));
            complaint.setQtrno(rs.getString("qtrno"));
            complaint.setEmpn(rs.getLong("empn"));
            complaint.setUsername(rs.getString("username"));
            complaint.setPhone(rs.getString("phone"));
            complaint.setCreatedate(rs.getString("compdatetime"));
            complaint.setStatus(rs.getString("status"));
            complaint.setAction(rs.getString("actiontaken"));
            electricalComplaints.add(complaint);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return electricalComplaints;
}


@Override
public List<Complaintdtls> getUserComplaints(long empn) {
    List<Complaintdtls> userComplaints = new ArrayList<>();
    try {
        String query = "SELECT * FROM complaintdtls WHERE empn=? ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setLong(1, empn);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Complaintdtls complaint = new Complaintdtls();
            complaint.setid(rs.getInt("id"));
            complaint.setImage(rs.getString("imagefile"));
            complaint.setCategory(rs.getString("category"));
            complaint.setTitle(rs.getString("title"));
            complaint.setDescription(rs.getString("description"));
            complaint.setQtrno(rs.getString("qtrno"));
            complaint.setEmpn(rs.getLong("empn"));
            complaint.setUsername(rs.getString("username"));
            complaint.setPhone(rs.getString("phone"));
            complaint.setCreatedate(rs.getString("compdatetime"));
            complaint.setStatus(rs.getString("status"));
            complaint.setAction(rs.getString("actiontaken"));
            userComplaints.add(complaint);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return userComplaints;
}

@Override
public List<Complaintdtls> getUserComplaintsByType(long empn, String type) {
    List<Complaintdtls> userComplaintsByType = new ArrayList<>();
    try {
        String query = "SELECT * FROM complaintdtls WHERE empn=? AND category=? ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setLong(1, empn);
        pstmt.setString(2, type);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Complaintdtls complaint = new Complaintdtls();
            complaint.setid(rs.getInt("id"));
            complaint.setImage(rs.getString("imagefile"));
            complaint.setCategory(rs.getString("category"));
            complaint.setTitle(rs.getString("title"));
            complaint.setDescription(rs.getString("description"));
            complaint.setQtrno(rs.getString("qtrno"));
            complaint.setEmpn(rs.getLong("empn"));
            complaint.setUsername(rs.getString("username"));
            complaint.setPhone(rs.getString("phone"));
            complaint.setCreatedate(rs.getString("compdatetime"));
            complaint.setStatus(rs.getString("status"));
            complaint.setAction(rs.getString("actiontaken"));
            userComplaintsByType.add(complaint);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return userComplaintsByType;
}



	
@Override
public List<Complaintdtls> getUserPreviousOneComplaint(long empn) {
    List<Complaintdtls> userPreviousOneComplaint = new ArrayList<>();
    try {
        String query = "SELECT * FROM complaintdtls WHERE empn=? ORDER BY id DESC FETCH FIRST 1 ROWS ONLY";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setLong(1, empn);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            Complaintdtls complaint = new Complaintdtls();
            complaint.setid(rs.getInt("id"));
            complaint.setImage(rs.getString("imagefile"));
            complaint.setCategory(rs.getString("category"));
            complaint.setTitle(rs.getString("title"));
            complaint.setDescription(rs.getString("description"));
            complaint.setQtrno(rs.getString("qtrno"));
            complaint.setEmpn(rs.getLong("empn"));
            complaint.setUsername(rs.getString("username"));
            complaint.setPhone(rs.getString("phone"));
            complaint.setCreatedate(rs.getString("compdatetime"));
            complaint.setStatus(rs.getString("status"));
            complaint.setAction(rs.getString("actiontaken"));
            userPreviousOneComplaint.add(complaint);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return userPreviousOneComplaint;
}


@Override

public List<Complaintdtls> getActiveComplaintsOfUser(long empn) {
    List<Complaintdtls> getActiveComplaintsOfUser = new ArrayList<>();
    try {
    	String query = "SELECT * FROM complaintdtls WHERE empn=? AND status=? ORDER BY id DESC";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setLong(1, empn);
        pstmt.setString(2, "Active");
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            Complaintdtls complaint = new Complaintdtls();
            complaint.setid(rs.getInt("id"));
            complaint.setImage(rs.getString("imagefile"));
            complaint.setCategory(rs.getString("category"));
            complaint.setTitle(rs.getString("title"));
            complaint.setDescription(rs.getString("description"));
            complaint.setQtrno(rs.getString("qtrno"));
            complaint.setEmpn(rs.getLong("empn"));
            complaint.setUsername(rs.getString("username"));
            complaint.setPhone(rs.getString("phone"));
            complaint.setCreatedate(rs.getString("compdatetime"));
            complaint.setStatus(rs.getString("status"));
            complaint.setAction(rs.getString("actiontaken"));
            getActiveComplaintsOfUser.add(complaint);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return getActiveComplaintsOfUser;
}
	



}
