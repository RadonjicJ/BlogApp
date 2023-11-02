package blog.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

@Entity
@Table
public class Message {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column
	private int id;
	
	@Column
	@NotNull
	@NotEmpty(message = "Required!")
	private String name;
	
	@Column
	@NotNull
	@NotEmpty(message="Email is required!")
	@Pattern(regexp = "^[a-z]+([0-9]+)?(\\.[a-z]+([0-9]+)?)?@[a-z]+(-[a-z]+)?(\\.[a-z]{2,3}){1,2}$", message = "Email is not valid!")
	private String email;
	
	@Column
	@NotNull
	@NotEmpty(message = "Required!")
	private String text;
	
	@Column(name="is_seen")
	private boolean isSeen;
	
	@Column
	private Timestamp time;
	
	public Message() {
	}

	public Message(String name, String email, String text, boolean isSeen) {
		super();
		this.name = name;
		this.email = email;
		this.text = text;
		this.isSeen = isSeen;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public boolean getIsSeen() {
		return isSeen;
	}

	public void setIsSeen(boolean isSeen) {
		this.isSeen = isSeen;
	}
	
	public Timestamp getTime() {
		return time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	@Override
	public String toString() {
		return name+ ": "+ text;
	}
}
