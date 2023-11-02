package blog.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import blog.entity.Category;
import blog.entity.Message;

@Repository
public class MessageDAOImpl implements MessageDAO{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Transactional
	@Override
	public List<Message> getMessageList() {
		Session session = sessionFactory.getCurrentSession();
		Query<Message> query = session.createQuery("from Message m order by m.time desc", Message.class);
		return query.getResultList();
		
	}

	@Transactional
	@Override
	public void saveMessage(Message message) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(message);
	}

	@Transactional
	@Override
	public void deleteMessage(int id) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("delete from Message where id=:id");
		query.setParameter("id", id);
		query.executeUpdate();
	}

	@Transactional
	@Override
	public void isSeenMessage(int id) {
		Session session = sessionFactory.getCurrentSession();
		Message message = session.get(Message.class, id);
		message.setIsSeen(!message.getIsSeen());
		
		session.saveOrUpdate(message);
	}

	@Transactional
	@Override
	public long getUnreadMessageCount() {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("select count(m.id) from Message m where m.isSeen=0");
		
		return (long) query.uniqueResult();
	}

}
