package blog.entity;


import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;


@Entity
@Table
public class Blog {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column
	private int id;
	
	@Column(name="blog_text")
	@NotNull
	@NotEmpty(message="Text is required")
	private String text;
	
	@Column
	@NotNull
	@NotEmpty(message="Title is required")
	@Size(min=20, max=255, message="minimum 20 characters, maximum 255 characters")
	private String title;
	
	@Column
	@NotNull
	@NotEmpty
	@Size(min=50, max=500, message="minimum 50 characters, maximum 500 characters")
	private String description;
	
	@Column(name="lead_image")
	private String image;
	
	@Column(name="second_image")
	private String secondImage;
	
	@Column
	private Timestamp time;
	
	@Column(name="blog_url")
	private String blogUrl;
	
	@Column(name="is_important")
	private boolean isImportant;
	
	@Column(name="number_of_views")
	private int numberOfViews;
	
	
	@ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
	@JoinColumn(name="category_id")
	private Category category;
	
	
	@ManyToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
	@JoinColumn(name="users_username")
	private User author;
	
	
	@ManyToMany(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
	@JoinTable(name="blog_tags", 
			   joinColumns = @JoinColumn(name="blog_id"), 
			   inverseJoinColumns = @JoinColumn(name="tag_id"))
	private List<Tag> tags;
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "blog")
	private List<Comment> comments;
	
	@Transient
	private long numberOfComment;
	
	@Transient
	private String timeAgo;
	
	
	public Blog() {
	}

	public Blog(String text, String title, String description, String image, Timestamp time, boolean isImportant,
			int numberOfViews) {
		super();
		this.text = text;
		this.title = title;
		this.description = description;
		this.image = image;
		this.time = time;
		this.isImportant = isImportant;
		this.numberOfViews = numberOfViews;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getBlogUrl() {
		return blogUrl;
	}

	public void setBlogUrl(String blogUrl) {
		this.blogUrl = blogUrl;
	}

	public boolean getIsImportant() {
		return isImportant;
	}

	public void setIsImportant(boolean isImportant) {
		this.isImportant = isImportant;
	}

	public int getNumberOfViews() {
		return numberOfViews;
	}

	public void setNumberOfViews(int numberOfViews) {
		this.numberOfViews = numberOfViews;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public User getAuthor() {
		return author;
	}

	public void setAuthor(User author) {
		this.author = author;
	}

	public List<Tag> getTags() {
		return tags;
	}

	public void setTags(List<Tag> tags) {
		this.tags = tags;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public long getNumberOfComment() {
		return numberOfComment;
	}

	public void setNumberOfComment(long numberOfComment) {
		this.numberOfComment = numberOfComment;
	}
	
	public Timestamp getTime() {
		return time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public String getSecondImage() {
		return secondImage;
	}

	public void setSecondImage(String secondImage) {
		this.secondImage = secondImage;
	}

	public String getTimeAgo() {
		return timeAgo;
	}

	public void setTimeAgo(String timeAgo) {
		this.timeAgo = timeAgo;
	}

	@Override
	public String toString() {
		return author.getUsername() + ": " + text;
	}
	
}
