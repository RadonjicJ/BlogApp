package blog.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import blog.entity.Category;

@Repository
public class CategoryDAOImpl implements CategoryDAO{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Transactional
	@Override
	public List<Category> getCategoryList() {
		Session session = sessionFactory.getCurrentSession();
		Query<Category> query = session.createQuery("from Category c order by c.order asc", Category.class);
		List<Category> categoryList = query.getResultList();
		
		for(Category category: categoryList) {
			Query queryCount = session.createQuery("select count(*) from Blog b where b.category.id=:id");
			queryCount.setParameter("id", category.getId());
			category.setNumberOfBlogs((long)queryCount.uniqueResult());
			
		}
		
		return categoryList;
	}

	@Transactional
	@Override
	public Category getCategory(int id) {
		Session session = sessionFactory.getCurrentSession();
		Category category = session.get(Category.class, id);
		
		return category;
	}

	@Transactional
	@Override
	public void saveCategory(Category category) {
		Session session = sessionFactory.getCurrentSession();
		
		session.saveOrUpdate(category);
		
	}

	@Transactional
	@Override
	public void deleteCategory(int id) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("delete from Category where id=:id");
		query.setParameter("id", id);
		query.executeUpdate();
		
	}
	
	@Transactional
	@Override
	public List<Category> getFourImportantCategory() {
		Session session = sessionFactory.getCurrentSession();
		Query<Category> query = session.createQuery("from Category c order by c.order asc", Category.class).setMaxResults(4);
		return query.getResultList();
	}

}
