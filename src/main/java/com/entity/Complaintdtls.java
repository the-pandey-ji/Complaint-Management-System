package com.entity;

import java.sql.Timestamp;

public class Complaintdtls {
	private int id;
	private String imagefile;
	private String category;
	private String title;
	private String description;
	private String qtrno;
	private String createdate;
	private long empn;
	private String username;
	private String phone;
	private String status;
	private String action;
	
	public Complaintdtls() {
		super();
	}
	
	private Timestamp closedDate;
	private String complaintType;

	public String getComplaintType() {
		return complaintType;
	}

	public void setComplaintType(String complaintType) {
		this.complaintType = complaintType;
	}
	public Timestamp getClosedDate() {
	    return closedDate;
	}

	public void setClosedDate(Timestamp closedDate) {
	    this.closedDate = closedDate;
	}
	
	public Complaintdtls(String imagefile, String category,String complaintType, String title, String description, String qtrno,
			 long empn, String username, String phone, String status, String action) {
		super();

		this.imagefile = imagefile;
		this.category = category;
		this.complaintType = complaintType;
		this.title = title;
		this.description = description;
		this.qtrno = qtrno;
		
		this.empn = empn;
		this.username = username;
		this.phone = phone;
		this.status = status;
		this.action = action;
	}
	
	
	// Constructor with id for editing existing complaints
	public Complaintdtls(int id,String imagefile, String category,String complaintType, String title, String description, String qtrno,
			 long empn, String username, String phone, String status, String action) {
		super();
		this.id = id;
		this.imagefile = imagefile;
		this.category = category;
		this.complaintType = complaintType;
		this.title = title;
		this.description = description;
		this.qtrno = qtrno;
		
		this.empn = empn;
		this.username = username;
		this.phone = phone;
		this.status = status;
		this.action = action;
	}
	
	
	public int getid() {
		return id;
	}

	public void setid(int id) {
		this.id = id;
	}
	
	public String getImage() {
		return imagefile;
	}
	public void setImage(String image) {
		this.imagefile = image;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getQtrno() {
		return qtrno;
	}
	public void setQtrno(String qtrno) {
		this.qtrno = qtrno;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public long getEmpn() {
		return empn;
	}
	public void setEmpn(long empn) {
		this.empn = empn;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	@Override
	public String toString() {
		return "Complaintdtls [id=" + id + ", image=" + imagefile + ", category=" + category + ", complaintType=" + complaintType +", title=" + title
				+ ", description=" + description + ", qtrno=" + qtrno + ", createdate=" + createdate + ", empn=" + empn
				+ ", username=" + username + ", phone=" + phone + ", status=" + status + ", action=" + action + "]";
	}
	
	
	

}
