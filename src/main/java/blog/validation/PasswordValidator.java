package blog.validation;


import java.util.regex.Pattern;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class PasswordValidator implements ConstraintValidator<ValidPassword, String>{

	@Override
	public void initialize(ValidPassword constraintAnnotation) {
	}
	
	
	@Override
	public boolean isValid(String password, ConstraintValidatorContext cvc ) {
	
		if(password.length()<8 && password.length()>20) {
			return false;
		}
		else if (!Pattern.compile("[1-9]").matcher(password).find()) {
			return false;
		}
		else if (!Pattern.compile("[a-z]").matcher(password).find()) {
			return false;
		}
		else if (!Pattern.compile("[A-Z]").matcher(password).find()) {
			return false;
		}
		else if (!Pattern.compile("[^A-Za-z0-9]").matcher(password).find()) {
			return false;
		}
		else if (Pattern.compile(" ").matcher(password).find()) {
			return false;
		}
		else {
			return true;
		}
		
	}

}
