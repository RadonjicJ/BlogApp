package blog.validation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

@Documented
@Constraint(validatedBy = PasswordValidator.class)
@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface ValidPassword {
	
	
	String message() default "Password must be between 8 and 20 character long."
			+ "It must have least: one number, one downcase, one uppercase, one special character "
			+ "and it must not contain whitespaces";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}
