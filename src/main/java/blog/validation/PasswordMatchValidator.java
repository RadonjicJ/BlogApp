package blog.validation;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import org.springframework.beans.BeanWrapperImpl;

public class PasswordMatchValidator implements ConstraintValidator<ValidPasswordMatch, Object>{

	String password;
	String passwordMatch;
	
	
	@Override
	public void initialize(ValidPasswordMatch constraintAnnotation) {
		this.password = constraintAnnotation.password();
		this.passwordMatch = constraintAnnotation.passwordMatch();
	}
	
	
	@Override
	public boolean isValid(Object value, ConstraintValidatorContext cvc) {
		
		Object passwordValue = new BeanWrapperImpl(value).getPropertyValue(password);
		Object passwordMatchValue = new BeanWrapperImpl(value).getPropertyValue(passwordMatch);

		if(passwordValue != null) {
			return passwordValue.equals(passwordMatchValue);
		}else {
			return passwordMatchValue == null;
		}
	}
}
