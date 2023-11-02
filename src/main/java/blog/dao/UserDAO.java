package blog.dao;

import java.util.List;

import blog.entity.Role;
import blog.entity.User;

public interface UserDAO {

	public List<User> getUserList();
	
	public User getUser(String username);
	
	public void saveUser(User user);
	
	public void deleteUser(String username);
	
	public void getEnabledUser(String username);
	
	
	// ROLES
	public List<Role> getRoleList();
	
	
	
}
