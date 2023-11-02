package blog.dao;

import java.util.List;

import blog.entity.Message;

public interface MessageDAO {

	public List<Message> getMessageList();
	
	public void saveMessage(Message message);
	
	public void deleteMessage(int id);
	
	public void isSeenMessage(int id);
	
	public long getUnreadMessageCount();
}
