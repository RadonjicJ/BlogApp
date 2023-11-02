package blog.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import blog.entity.Slide;

@Repository
public class SlideDAOImpl implements SlideDAO{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Transactional
	@Override
	public List<Slide> getSlideList() {
		Session session = sessionFactory.getCurrentSession();
		Query<Slide> query = session.createQuery("from Slide s order by s.order asc", Slide.class);
		return query.getResultList();
	}

	@Transactional
	@Override
	public Slide getSlide(int id) {
		Session session = sessionFactory.getCurrentSession();
		Slide slide = session.get(Slide.class, id);
		return slide;
	}

	@Transactional
	@Override
	public void saveSlide(Slide slide) {
		Session session = sessionFactory.getCurrentSession();
		
		session.saveOrUpdate(slide);
		
	}

	@Transactional
	@Override
	public void deleteSlide(int id) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("delete from Slide where id=:id");
		query.setParameter("id", id);
		query.executeUpdate();
	}

	@Transactional
	@Override
	public void getEnabledSlide(int id) {
		Session session = sessionFactory.getCurrentSession();
		Slide slide = session.get(Slide.class, id);
		slide.setEnabled(!slide.getEnabled());
		session.saveOrUpdate(slide);
	}

	@Transactional
	@Override
	public List<Slide> getSlideListForIndexPage() {
		Session session = sessionFactory.getCurrentSession();
		Query<Slide> query = session.createQuery("from Slide s where s.enabled=1 order by s.order asc", Slide.class);
		return query.getResultList();
	}

}
