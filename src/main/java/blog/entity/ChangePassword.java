package blog.entity;

import blog.validation.ValidPassword;
import blog.validation.ValidPasswordMatch;

@ValidPasswordMatch(password = "newPassword", passwordMatch = "confirmPassword", message = "Password do not match!")
public class ChangePassword {

	private String oldPassword;
	
	@ValidPassword
	private String newPassword;

	private String confirmPassword;
	
	
	public ChangePassword() {
	}

	public ChangePassword(String oldPassword, String newPassword, String confirmPassword) {
		super();
		this.oldPassword = oldPassword;
		this.newPassword = newPassword;
		this.confirmPassword = confirmPassword;
	}

	public String getOldPassword() {
		return oldPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
	
	
}
