package com.entity;

public class Complaintdtls {
	private int cid;
	private String imagefile;
	private String category;
	private String title;
	private String description;
	private String qtrno;
	private String createdate;
	private int empn;
	private String username;
	private String phone;
	private String status;
	private String action;
	public Complaintdtls(String imagefile, String category, String title, String description, String qtrno,
			 int empn, String username, String phone, String status, String action) {
		super();

		this.imagefile = imagefile;
		this.category = category;
		this.title = title;
		this.description = description;
		this.qtrno = qtrno;
		
		this.empn = empn;
		this.username = username;
		this.phone = phone;
		this.status = status;
		this.action = action;
	}
	
	
	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
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
	public int getEmpn() {
		return empn;
	}
	public void setEmpn(int empn) {
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
		return "Complaintdtls [cid=" + cid + ", image=" + imagefile + ", category=" + category + ", title=" + title
				+ ", description=" + description + ", qtrno=" + qtrno + ", createdate=" + createdate + ", empn=" + empn
				+ ", username=" + username + ", phone=" + phone + ", status=" + status + ", action=" + action + "]";
	}
	
	
	

}
