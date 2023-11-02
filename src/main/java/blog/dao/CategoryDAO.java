package blog.dao;

import java.util.List;

import blog.entity.Category;

public interface CategoryDAO {

	public List<Category> getCategoryList();
	
	public Category getCategory(int id);
	
	public void saveCategory(Category category);
	
	public void deleteCategory(int id);
	
	public List<Category> getFourImportantCategory();
}
