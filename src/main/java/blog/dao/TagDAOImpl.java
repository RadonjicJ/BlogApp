package blog.dao;

import java.util.Comparator;
import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import blog.entity.Tag;

@Repository
public class TagDAOImpl implements TagDAO{

	@Autowired
	private SessionFactory sessionFactory;
	
	
	@Transactional
	@Override
	public List<Tag> getTagList() {
		Session session = sessionFactory.getCurrentSession();
		Query<Tag> query = session.createQuery("from Tag", Tag.class);
		return query.getResultList();
	}

	@Transactional
	@Override
	public Tag getTag(int id) {
		Session session = sessionFactory.getCurrentSession();
		Tag tag = session.get(Tag.class, id);
		return tag;
	}

	@Transactional
	@Override
	public void saveTag(Tag tag) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(tag);
	}

	@Transactional
	@Override
	public void deleteTag(int id) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("delete from Tag where id=:id");
		query.setParameter("id", id);
		query.executeUpdate();
	}

	@Transactional
	@Override
	public List<Tag> getAllTagById(List<Integer> ids) {
		Session session = sessionFactory.getCurrentSession();
		Query<Tag> query = session.createQuery("select t from Tag t where t.id in(:ids)", Tag.class);
		query.setParameter("ids", ids);
		
		return query.getResultList();
	}
	
	@Transactional
	@Override
	public List<Tag> getTagListWithBlogs() {
		Session session = sessionFactory.getCurrentSession();
		Query<Tag> query = session.createQuery("from Tag", Tag.class);
		List<Tag> tagList = query.getResultList();
		
		for(Tag tag: tagList) {
			Hibernate.initialize(tag.getBlogs());
			tag.setNumberOfBlogs(tag.getBlogs().size());
		}
		tagList.sort(Comparator.comparing(Tag::getNumberOfBlogs).reversed());
		return tagList;
	}

	@Transactional
	@Override
	public Tag getTagWithBlogs(String tagUrl) {
		Session session = sessionFactory.getCurrentSession();
		Query<Tag> query = session.createQuery("from Tag t where t.tagUrl=:tagUrl", Tag.class);
		query.setParameter("tagUrl", tagUrl);
		
		Tag tag = query.getSingleResult();
		
		Hibernate.initialize(tag.getBlogs());
		return tag;
	}

}
