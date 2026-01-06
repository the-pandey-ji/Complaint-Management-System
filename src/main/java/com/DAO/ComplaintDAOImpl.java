package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.Complaintdtls;
import com.entity.User;


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
        String sql =
            "UPDATE CTRACK.COMPLAINTDTLS " +
            "SET STATUS = 'Closed', " +
            "ACTIONTAKEN = ?, " +
            "CLOSED_DATE = SYSTIMESTAMP " +
            "WHERE ID = ?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, actionTaken);
        ps.setInt(2, id);

        result = ps.executeUpdate() == 1;
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
	

@Override
public int getTotalComplaintCountByCategory(String category) {
    int count = 0;
    try {
        String sql =
            "SELECT COUNT(*) FROM CTRACK.COMPLAINTDTLS WHERE CATEGORY = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, category);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) count = rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}

@Override
public int getOpenComplaintCountByCategory(String category) {
    int count = 0;
    try {
        String sql =
            "SELECT COUNT(*) FROM CTRACK.COMPLAINTDTLS " +
            "WHERE CATEGORY = ? " +
            "AND STATUS IN ('Submitted','Assigned', 'Active','In Progress','On Hold')";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, category);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) count = rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}

@Override
public int getClosedComplaintCountByCategory(String category) {
    int count = 0;
    try {
        String sql =
            "SELECT COUNT(*) FROM CTRACK.COMPLAINTDTLS " +
            "WHERE CATEGORY = ? AND STATUS = 'Closed'";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, category);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) count = rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}


@Override
public int getClosedComplaintCountByCategorytoday(String category) {
    int count = 0;
    try {
        String sql =
            "SELECT COUNT(*) FROM CTRACK.COMPLAINTDTLS " +
            "WHERE CATEGORY = ? AND STATUS = 'Closed' AND TRUNC(CLOSED_DATE) = TRUNC(SYSDATE)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, category);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) count = rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}

@Override
public List<Complaintdtls> getComplaintsPaginated(
        String category,
        int startRow,
        int endRow) {

    List<Complaintdtls> list = new ArrayList<>();

    try {
        String sql =
            "SELECT * FROM ( " +
            "  SELECT a.*, ROWNUM rnum FROM ( " +
            "    SELECT * FROM CTRACK.COMPLAINTDTLS " +
            "    WHERE CATEGORY = ? " +
            "    ORDER BY COMPDATETIME DESC " +
            "  ) a WHERE ROWNUM <= ? " +
            ") WHERE rnum >= ?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, category);
        ps.setInt(2, endRow);
        ps.setInt(3, startRow);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Complaintdtls c = new Complaintdtls();
            c.setid(rs.getInt("ID"));
            c.setCategory(rs.getString("CATEGORY"));
            c.setTitle(rs.getString("TITLE"));
            c.setDescription(rs.getString("DESCRIPTION"));
            c.setCreatedate(rs.getString("COMPDATETIME"));
            c.setClosedDate(rs.getTimestamp("CLOSED_DATE"));
            c.setStatus(rs.getString("STATUS"));
            c.setImage(rs.getString("IMAGEFILE"));
            c.setUsername(rs.getString("USERNAME"));
            c.setPhone(rs.getString("PHONE"));
            c.setQtrno(rs.getString("QTRNO"));
            c.setEmpn(rs.getLong("EMPN"));
            c.setAction(rs.getString("ACTIONTAKEN"));
            list.add(c);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}

@Override
public int getComplaintCountByCategory(String category) {
    int count = 0;
    try {
        String sql =
            "SELECT COUNT(*) FROM CTRACK.COMPLAINTDTLS WHERE CATEGORY = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, category);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) count = rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}

@Override
public List<Complaintdtls> getComplaintsPaginatedSearch(
        String category,
        String search,
        int startRow,
        int endRow) {

    List<Complaintdtls> list = new ArrayList<>();

    try {
        String sql =
            "SELECT * FROM ( " +
            "  SELECT a.*, ROWNUM rnum FROM ( " +
            "    SELECT * FROM CTRACK.COMPLAINTDTLS " +
            "    WHERE CATEGORY = ? " +
            "    AND ( " +
            "      LOWER(USERNAME) LIKE ? OR " +
            "      QTRNO LIKE ? OR " +
            "      PHONE LIKE ? OR " +
            "      TO_CHAR(COMPDATETIME,'YYYY-MM-DD') LIKE ? OR " +
            "      TO_CHAR(EMPN) LIKE ? " +
            "    ) " +
            "    ORDER BY COMPDATETIME DESC " +
            "  ) a WHERE ROWNUM <= ? " +
            ") WHERE rnum >= ?";

        PreparedStatement ps = conn.prepareStatement(sql);

        String like = "%" + search.toLowerCase() + "%";

        ps.setString(1, category);
        ps.setString(2, like); // username
        ps.setString(3, like); // qtr
        ps.setString(4, like); // phone
        ps.setString(5, like); // date
        ps.setString(6, like); // empn
        ps.setInt(7, endRow);
        ps.setInt(8, startRow);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Complaintdtls c = new Complaintdtls();
            c.setid(rs.getInt("ID"));
            c.setCategory(rs.getString("CATEGORY"));
            c.setTitle(rs.getString("TITLE"));
            c.setDescription(rs.getString("DESCRIPTION"));
            c.setCreatedate(rs.getString("COMPDATETIME"));
            c.setClosedDate(rs.getTimestamp("CLOSED_DATE"));
            c.setStatus(rs.getString("STATUS"));
            c.setImage(rs.getString("IMAGEFILE"));
            c.setUsername(rs.getString("USERNAME"));
            c.setPhone(rs.getString("PHONE"));
            c.setQtrno(rs.getString("QTRNO"));
            c.setEmpn(rs.getLong("EMPN"));
            c.setAction(rs.getString("ACTIONTAKEN"));
            list.add(c);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}

@Override

public int getComplaintCountByCategorySearch(String category, String search) {

    int count = 0;

    try {
        String sql =
            "SELECT COUNT(*) FROM CTRACK.COMPLAINTDTLS " +
            "WHERE CATEGORY = ? " +
            "AND ( " +
            "  LOWER(USERNAME) LIKE ? OR " +
            "  QTRNO LIKE ? OR " +
            "  PHONE LIKE ? OR " +
            "  TO_CHAR(COMPDATETIME,'YYYY-MM-DD') LIKE ? OR " +
            "  TO_CHAR(EMPN) LIKE ? " +
            ")";

        PreparedStatement ps = conn.prepareStatement(sql);

        String like = "%" + search.toLowerCase() + "%";

        ps.setString(1, category);
        ps.setString(2, like);
        ps.setString(3, like);
        ps.setString(4, like);
        ps.setString(5, like);
        ps.setString(6, like);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            count = rs.getInt(1);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return count;
}

@Override
public List<Complaintdtls> getPendingComplaintsPaginatedSearch(
        String category,
        String search,
        int startRow,
        int endRow) {

    List<Complaintdtls> list = new ArrayList<>();

    try {
        String sql =
            "SELECT * FROM ( " +
            "  SELECT a.*, ROWNUM rnum FROM ( " +
            "    SELECT * FROM CTRACK.COMPLAINTDTLS " +
            "    WHERE CATEGORY = ? " +
            "      AND STATUS <> 'Closed' " +
            "      AND ( " +
            "           LOWER(USERNAME) LIKE ? " +
            "        OR TO_CHAR(EMPN) LIKE ? " +
            "        OR LOWER(QTRNO) LIKE ? " +
            "        OR PHONE LIKE ? " +
            "        OR TO_CHAR(COMPDATETIME,'YYYY-MM-DD') LIKE ? " +
            "      ) " +
            "    ORDER BY COMPDATETIME DESC " +
            "  ) a WHERE ROWNUM <= ? " +
            ") WHERE rnum >= ?";

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, category);

        String like = "%" + search.toLowerCase() + "%";
        ps.setString(2, like); // username
        ps.setString(3, "%" + search + "%"); // empn
        ps.setString(4, like); // qtr
        ps.setString(5, "%" + search + "%"); // phone
        ps.setString(6, "%" + search + "%"); // date

        ps.setInt(7, endRow);
        ps.setInt(8, startRow);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Complaintdtls c = new Complaintdtls();
            c.setid(rs.getInt("ID"));
            c.setImage(rs.getString("IMAGEFILE"));
            c.setCategory(rs.getString("CATEGORY"));
            c.setTitle(rs.getString("TITLE"));
            c.setDescription(rs.getString("DESCRIPTION"));
            c.setQtrno(rs.getString("QTRNO"));
            c.setEmpn(rs.getLong("EMPN"));
            c.setUsername(rs.getString("USERNAME"));
            c.setPhone(rs.getString("PHONE"));
            c.setCreatedate(rs.getString("COMPDATETIME"));
            c.setClosedDate(rs.getTimestamp("CLOSED_DATE"));
            c.setStatus(rs.getString("STATUS"));
            c.setAction(rs.getString("ACTIONTAKEN"));

            list.add(c);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}


@Override

public int getPendingComplaintCountByCategorySearch(
        String category,
        String search) {

    int count = 0;

    try {
        String sql =
            "SELECT COUNT(*) FROM CTRACK.COMPLAINTDTLS " +
            "WHERE CATEGORY = ? " +
            "  AND STATUS <> 'Closed' " +
            "  AND ( " +
            "       LOWER(USERNAME) LIKE ? " +
            "    OR TO_CHAR(EMPN) LIKE ? " +
            "    OR LOWER(QTRNO) LIKE ? " +
            "    OR PHONE LIKE ? " +
            "    OR TO_CHAR(COMPDATETIME,'YYYY-MM-DD') LIKE ? " +
            "  )";

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, category);

        String like = "%" + search.toLowerCase() + "%";
        ps.setString(2, like);
        ps.setString(3, "%" + search + "%");
        ps.setString(4, like);
        ps.setString(5, "%" + search + "%");
        ps.setString(6, "%" + search + "%");

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            count = rs.getInt(1);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return count;
}


@Override

public List<User> getAllUsers() {
    List<User> list = new ArrayList<>();
    try {
        String sql = "SELECT * FROM CTRACK.USERMASTER ORDER BY EMPN";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            User u = new User();
            u.setEmpn(rs.getLong("EMPN"));
            u.setUsername(rs.getString("USERNAME"));
            u.setQtrno(rs.getString("QTRNO"));
            u.setEmail(rs.getString("EMAIL"));
            u.setPhone(rs.getString("PHONE"));
            u.setStatus(rs.getString("STATUS"));
            u.setRole(rs.getString("ROLE"));
            list.add(u);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

@Override
public boolean addUser(User u) {
    boolean flag = false;
    try {
        String sql =
            "INSERT INTO CTRACK.USERMASTER " +
            "(EMPN, USERNAME, QTRNO, EMAIL, PHONE, PASSWORD, USERCREATIONDATE, STATUS, ROLE) " +
            "VALUES (?, ?, ?, ?, ?, ?, SYSDATE, ?, ?)";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setLong(1, u.getEmpn());
        ps.setString(2, u.getUsername());
        ps.setString(3, u.getQtrno());
        ps.setString(4, u.getEmail());
        ps.setString(5, u.getPhone());
        ps.setString(6, u.getPassword());
        ps.setString(7, "A");   // Active
        ps.setString(8, u.getRole());

        flag = ps.executeUpdate() == 1;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return flag;
}


@Override
public User getUserByEmpn(long empn) {
    User u = null;
    try {
        String sql = "SELECT * FROM CTRACK.USERMASTER WHERE EMPN=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setLong(1, empn);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            u = new User();
            u.setEmpn(rs.getLong("EMPN"));
            u.setUsername(rs.getString("USERNAME"));
            u.setQtrno(rs.getString("QTRNO"));
            u.setEmail(rs.getString("EMAIL"));
            u.setPhone(rs.getString("PHONE"));
            u.setStatus(rs.getString("STATUS"));
            u.setRole(rs.getString("ROLE"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return u;
}

@Override
public boolean updateUser(User u) {
    boolean flag = false;
    try {
        String sql =
            "UPDATE CTRACK.USERMASTER SET " +
            "USERNAME=?, QTRNO=?, EMAIL=?, PHONE=?, STATUS=?, ROLE=? " +
            "WHERE EMPN=?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, u.getUsername());
        ps.setString(2, u.getQtrno());
        ps.setString(3, u.getEmail());
        ps.setString(4, u.getPhone());
        ps.setString(5, u.getStatus());
        ps.setString(6, u.getRole());
        ps.setLong(7, u.getEmpn());

        flag = ps.executeUpdate() == 1;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return flag;
}

@Override
public boolean deleteUser(long empn) {
    boolean flag = false;
    try {
        String sql = "DELETE FROM CTRACK.USERMASTER WHERE EMPN=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setLong(1, empn);
        flag = ps.executeUpdate() == 1;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return flag;
}
/*
 * @Override public double getAvgResolutionDaysByCategory(String category) {
 * 
 * double avgDays = 0;
 * 
 * try { String sql =
 * "SELECT NVL(ROUND(AVG(CAST(CLOSED_DATE AS DATE) - COMPDATETIME), 2), 0) " +
 * "FROM CTRACK.COMPLAINTDTLS " + "WHERE STATUS = 'Closed' " +
 * "AND CATEGORY = ? " + "AND CLOSED_DATE IS NOT NULL " +
 * "AND COMPDATETIME IS NOT NULL " +
 * "AND CAST(CLOSED_DATE AS DATE) >= COMPDATETIME";
 * 
 * PreparedStatement ps = conn.prepareStatement(sql); ps.setString(1, category);
 * 
 * ResultSet rs = ps.executeQuery(); if (rs.next()) { avgDays = rs.getDouble(1);
 * }
 * 
 * } catch (Exception e) { e.printStackTrace(); }
 * 
 * return avgDays; }
 */


@Override
public int getTotalComplaintCountByUser(long empn) {
    int count = 0;
    try {
        String sql =
            "SELECT COUNT(*) FROM CTRACK.COMPLAINTDTLS WHERE EMPN = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setLong(1, empn);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) count = rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}
@Override
public int getOpenComplaintCountByUser(long empn) {
    int count = 0;
    try {
        String sql =
            "SELECT COUNT(*) FROM CTRACK.COMPLAINTDTLS " +
            "WHERE EMPN = ? AND STATUS <> 'Closed'";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setLong(1, empn);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) count = rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}
@Override
public int getClosedComplaintCountByUser(long empn) {
    int count = 0;
    try {
        String sql =
            "SELECT COUNT(*) FROM CTRACK.COMPLAINTDTLS " +
            "WHERE EMPN = ? AND STATUS = 'Closed'";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setLong(1, empn);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) count = rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return count;
}



@Override


public int[] getMonthlyComplaintCountByUser(long empn) {
    int[] counts = new int[12]; // Jan–Dec

    try {
        String sql =
            "SELECT TO_CHAR(COMPDATETIME,'MM') MM, COUNT(*) CNT " +
            "FROM CTRACK.COMPLAINTDTLS " +
            "WHERE EMPN = ? " +
            "AND TO_CHAR(COMPDATETIME,'YYYY') = TO_CHAR(SYSDATE,'YYYY') " +
            "GROUP BY TO_CHAR(COMPDATETIME,'MM')";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setLong(1, empn);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            int month = Integer.parseInt(rs.getString("MM"));
            counts[month - 1] = rs.getInt("CNT");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return counts;
}



}
