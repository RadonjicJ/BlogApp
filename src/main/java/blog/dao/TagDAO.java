package blog.dao;

import java.util.List;

import blog.entity.Tag;

public interface TagDAO {

	public List<Tag> getTagList();

	public List<Tag> getTagListWithBlogs();
	
	public Tag getTag(int id);
	
	public void saveTag(Tag tag);
	
	public void deleteTag(int id);
	
	public List<Tag> getAllTagById(List<Integer> ids);
	
	public Tag getTagWithBlogs(String tagUrl);
}
