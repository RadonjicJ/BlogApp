package blog.backend;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AuthController {

	
	@RequestMapping("/login-page")
	public String getLoginPage() {
		
		return "login-page";
	}

	

	

}
