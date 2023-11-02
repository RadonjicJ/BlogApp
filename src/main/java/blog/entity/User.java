package blog.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

@Entity
@Table(name="users")
public class User {

	@Id
	@Column
	@NotNull
	@NotEmpty(message="Username is required!")
	private String username;
	
	@Column
	@NotNull
	@NotEmpty(message="Password is required!")
	private String password;
	
	@Column
	@NotNull
	@NotEmpty(message="Name is required!")
	private String name;
	
	@Column
	@NotNull
	@NotEmpty(message="Surname is required!")
	private String surname;
	
	@Column
	@NotNull
	@NotEmpty(message="Email is required!")
	@Pattern(regexp = "^[a-z]+([0-9]+)?(\\.[a-z]+([0-9]+)?)?@[a-z]+(-[a-z]+)?(\\.[a-z]{2,3}){1,2}$", message = "Email is not valid!")
	private String email;
	
	@Column
	@NotNull
	@NotEmpty(message="Phone is required!")
	private String phone;
	
	@Column
	private String image;
	
	@Column
	private boolean enabled;
	
	@Valid
	@ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.EAGER)
	@JoinTable(name="authorities", 
			   joinColumns = @JoinColumn(name="username"), 
			   inverseJoinColumns = @JoinColumn(name="authority"))
	private List<Role> authorities;
	
	
	public User() {
		
	}

	public User(String username, String password, String name, String surname, String email, String phone, String image,
			boolean enabled) {
		super();
		this.username = username;
		this.password = password;
		this.name = name;
		this.surname = surname;
		this.email = email;
		this.phone = phone;
		this.image = image;
		this.enabled = enabled;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
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

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public List<Role> getAuthorities() {
		return authorities;
	}

	public void setAuthorities(List<Role> authorities) {
		this.authorities = authorities;
	}
	
	
	
}
