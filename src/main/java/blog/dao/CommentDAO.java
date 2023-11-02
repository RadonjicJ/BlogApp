package blog.dao;

import java.util.List;

import blog.entity.Comment;


public interface CommentDAO {

public List<Comment> getCommentList();
	
	public void saveComment(Comment comment);
	
	public void deleteComment(int id);
	
	public void isEnabledComment(int id);
}
