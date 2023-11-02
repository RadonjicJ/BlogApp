package blog.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import blog.entity.Role;
import blog.entity.User;

@Repository
public class UserDAOImpl implements UserDAO{
	
	@Autowired
	private SessionFactory sessionFactory;
	
	@Transactional
	@Override
	public List<User> getUserList() {
		Session session = sessionFactory.getCurrentSession();
		Query<User> query = session.createQuery("from User", User.class);
		return query.getResultList();
	}

	@Transactional
	@Override
	public User getUser(String username) {
		Session session = sessionFactory.getCurrentSession();
		User user = session.get(User.class, username);
		return user;
	}

	@Transactional
	@Override
	public void saveUser(User user) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(user);
		
	}

	@Transactional
	@Override
	public void deleteUser(String username) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("delete from User where id=:id");
		query.setParameter("id", username);
		query.executeUpdate();
	}

	
	/*
	 *  ROLES
	 */
	
	@Transactional
	@Override
	public List<Role> getRoleList() {
		Session session = sessionFactory.getCurrentSession();
		Query<Role> query = session.createQuery("from Role", Role.class);
		return query.getResultList();
	}

	@Transactional
	@Override
	public void getEnabledUser(String username) {
		Session session = sessionFactory.getCurrentSession();
		User user = session.get(User.class, username);
		user.setEnabled(!user.getEnabled());
		session.saveOrUpdate(user);
		
	}

	

}
