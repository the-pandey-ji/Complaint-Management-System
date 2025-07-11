package com.entity;

public class User {
	
	private long empn;
	private String username;
	private String qtrno;
	private String email;
	private String phone;
	private String password;
	
	
	
	
	
	public User() {
		super();
		// TODO Auto-generated constructor stub
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
	public String getQtrno() {
		return qtrno;
	}
	public void setQtrno(String qtrno) {
		this.qtrno = qtrno;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	@Override
	public String toString() {
		return "User [empn=" + empn + ", username=" + username + ", qtrno=" + qtrno + ", email=" + email + ", phone="
				+ phone + ", password=" + password + "]";
	}
	
	
	

}
