package blog;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Autowired
	private DataSource mydataSource;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.jdbcAuthentication().dataSource(mydataSource);
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		http.authorizeRequests()
			.antMatchers("/").permitAll()
			
			.antMatchers("/administration/slide-list").hasRole("admin")
			.antMatchers("/administration/slide-form").hasRole("admin")
			.antMatchers("/administration/slide-save").hasRole("admin")
			.antMatchers("/administration/slide-update-form").hasRole("admin")
			.antMatchers("/administration/slide-delete").hasRole("admin")
			.antMatchers("/administration/slide-enabled").hasRole("admin")
			
			.antMatchers("/administration/tag-list").hasRole("admin")
			.antMatchers("/administration/tag-form").hasRole("admin")
			.antMatchers("/administration/tag-save").hasRole("admin")
			.antMatchers("/administration/tag-update-form").hasRole("admin")
			.antMatchers("/administration/tag-delete").hasRole("admin")
			
			.antMatchers("/administration/category-list").hasRole("admin")
			.antMatchers("/administration/category-form").hasRole("admin")
			.antMatchers("/administration/category-save").hasRole("admin")
			.antMatchers("/administration/category-update-form").hasRole("admin")
			.antMatchers("/administration/category-delete").hasRole("admin")
						
			.antMatchers("/administration/user-list").hasRole("admin")
			.antMatchers("/administration/user-form").hasRole("admin")
			.antMatchers("/administration/user-save").hasRole("admin")
			.antMatchers("/administration/user-delete").hasRole("admin")
			.antMatchers("/administration/user-enabled").hasRole("admin")
					
			.antMatchers("/administration/message-list").hasRole("admin")
			.antMatchers("/administration/message-delete").hasRole("admin")
			.antMatchers("/administration/message-is-seen").hasRole("admin")
			
			.antMatchers("/administration/**").hasAnyRole("blogger", "admin")
			.and()
			.formLogin()
			.loginPage("/login-page")
			.loginProcessingUrl("/authenticateTheUser").permitAll()
			.and()
			.rememberMe()
			.and()
			.logout().deleteCookies("remember-me");     
	}
	
	

}
