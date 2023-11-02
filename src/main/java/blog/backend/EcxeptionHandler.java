package blog.backend;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class EcxeptionHandler {
	
	@ExceptionHandler
	private String handleException(Exception exception) {
		
		return "error";
	}

}
