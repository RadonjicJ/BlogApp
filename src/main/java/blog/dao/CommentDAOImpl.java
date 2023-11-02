package blog.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import blog.entity.Comment;

@Repository
public class CommentDAOImpl implements CommentDAO{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Transactional
	@Override
	public List<Comment> getCommentList() {
		Session session = sessionFactory.getCurrentSession();
		Query<Comment> query = session.createQuery("from Comment", Comment.class);
		return query.getResultList();
	}

	@Transactional
	@Override
	public void saveComment(Comment comment) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(comment);
	}

	@Transactional
	@Override
	public void deleteComment(int id) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("delete from Comment where id=:id");
		query.setParameter("id", id);
		query.executeUpdate();
	}

	@Transactional
	@Override
	public void isEnabledComment(int id) {
		Session session = sessionFactory.getCurrentSession();
		Comment comment = session.get(Comment.class, id);
		comment.setEnabled(!comment.getEnabled());
		
		session.saveOrUpdate(comment);
		
	}

}
