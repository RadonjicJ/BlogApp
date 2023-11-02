package blog.dao;

import java.sql.Timestamp;
import java.util.List;

import blog.entity.Blog;



public interface BlogDAO{
	
	public List<Blog> getBlogList();
	
	public Blog getBlog(int id);
	
	public Blog getBlogWithTags(int id);
	
	public Blog getBlogWithCommentsAndTags(String url);
	
	
	
	public void saveBlog(Blog blog);
	
	public void deleteBlog(int id);
	
	public void setImportantBlog(int id);
	
	public void incrementViews(String url);
	
	
	
	
	public List<Blog> getThreeImportantLatestBlog();
	
	public List<Blog> getLatestBlog(int limit);
	
	public List<Blog> getThreeBestVisitBlog();
	
	public List<Blog> getAllBlogByAuthor(String username);
	
	public List<Blog> getAllBlogByCategory(String categoryUrl);
	
	public Blog getNextBlog(Timestamp time);
	
	public Blog getPreviousBlog(Timestamp time);
	
	public List<Blog> getSearchBlog(String searchTerm);
	
	
}
