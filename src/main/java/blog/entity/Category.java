package blog.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Entity
@Table
public class Category {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column
	private int id;
	
	@Column
	@NotNull
	@NotEmpty(message = "Name is required!")
	private String name;
	
	@Column
	@NotNull
	@NotEmpty(message = "Description is required!")
	private String description;
	
	@Column(name="order_list")
	private int order;
	
	@Column(name="category_url")
	private String categoryUrl;
	
	@Transient
	private long numberOfBlogs;
	
	
	public Category() {
		
	}

	public Category(String name, String description, int order) {
		super();
		this.name = name;
		this.description = description;
		this.order = order;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public int getOrder() {
		return order;
	}

	public void setOrder(int order) {
		this.order = order;
	}
	
	public long getNumberOfBlogs() {
		return numberOfBlogs;
	}

	public void setNumberOfBlogs(long numberOfBlogs) {
		this.numberOfBlogs = numberOfBlogs;
	}

	public String getCategoryUrl() {
		return categoryUrl;
	}

	public void setCategoryUrl(String categoryUrl) {
		this.categoryUrl = categoryUrl;
	}

	@Override
	public String toString() {
		return name;
	}
}
