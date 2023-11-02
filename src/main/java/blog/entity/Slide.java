package blog.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Entity
@Table
public class Slide {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column
	private int id;
	
	@Column
	@NotNull
	@NotEmpty(message="Title is required")
	private String title;
	
	@Column
	private String image;
	
	@Column(name="button_name")
	@NotNull
	@NotEmpty(message = "Button title is required!")
	private String buttonTitle;
	
	@Column(name="button_url")
	@NotNull
	@NotEmpty(message = "Url is required!")
	private String buttonUrl;
	
	@Column(name="is_enabled")
	private boolean enabled;
	
	@Column(name="order_list")
	private int order;
	
	public Slide() {
	
	}

	public Slide(String title, String image, String buttonTitle, String buttonUrl, boolean enabled, int order) {
		super();
		this.title = title;
		this.image = image;
		this.buttonTitle = buttonTitle;
		this.buttonUrl = buttonUrl;
		this.enabled = enabled;
		this.order = order;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getButtonTitle() {
		return buttonTitle;
	}

	public void setButtonTitle(String buttonTitle) {
		this.buttonTitle = buttonTitle;
	}

	public String getButtonUrl() {
		return buttonUrl;
	}

	public void setButtonUrl(String buttonUrl) {
		this.buttonUrl = buttonUrl;
	}

	public boolean getEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public int getOrder() {
		return order;
	}

	public void setOrder(int order) {
		this.order = order;
	}
	
	
	
}
