package com.DAO;

import com.entity.User;

public interface UserDAO {
	public boolean userRegister(User us);
	
	public User userLogin(long empn, String password);
	
	public User getUserByEmpn(long empn);
	
	public boolean updatePassword(long empn, String newPassword);

}
