package blog.dao;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import blog.entity.Blog;
import blog.entity.Comment;

@Repository
public class BlogDAOImpl implements BlogDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Transactional
	@Override
	public List<Blog> getBlogList() {
		Session session = sessionFactory.getCurrentSession();
		Query<Blog> query = session.createQuery("from Blog", Blog.class);
		
		List<Blog> blogList = query.getResultList();
		
		countComments(blogList, session);
		
		return blogList;
	}

	@Transactional
	@Override
	public Blog getBlog(int id) {
		Session session = sessionFactory.getCurrentSession();
		Blog blog = session.get(Blog.class, id);
		
		return blog;
	}
	
	
	@Transactional
	@Override
	public Blog getBlogWithTags(int id) {
		Session session = sessionFactory.getCurrentSession();
		Blog blog = session.get(Blog.class, id);
		Hibernate.initialize(blog.getTags());
		
		return blog;
	}

	@Transactional
	@Override
	public Blog getBlogWithCommentsAndTags(String url) {
		Session session = sessionFactory.getCurrentSession();
		Query<Blog> query = session.createQuery("from Blog b where b.blogUrl like :url", Blog.class);
		query.setParameter("url", url);
		
		Blog blog = query.getSingleResult();
		Hibernate.initialize(blog.getTags());
		
		Query<Comment> queryComment = session.createQuery("select c from Comment c where c.enabled=1 and c.blog.id=:id",Comment.class);
		queryComment.setParameter("id", blog.getId());
		
		List<Comment> commentList = queryComment.getResultList();
		blog.setComments(commentList);
		
		return blog;
	}
	
	

	@Transactional
	@Override
	public void saveBlog(Blog blog) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(blog);
		
	}

	@Transactional
	@Override
	public void deleteBlog(int id) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("delete from Blog where id=:id");
		query.setParameter("id", id);
		query.executeUpdate();
	}


	@Transactional
	@Override
	public void setImportantBlog(int id) {
		Session session = sessionFactory.getCurrentSession();
		Blog blog = session.get(Blog.class, id);
		blog.setIsImportant(!blog.getIsImportant());
		session.saveOrUpdate(blog);
	}
	
	
	@Transactional
	@Override
	public void incrementViews(String url) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("update Blog b set b.numberOfViews =(select bl.numberOfViews from Blog bl where bl.blogUrl like :url)+1 where b.blogUrl like :url");
		query.setParameter("url", url);
		query.executeUpdate();
	}
	
	

	@Transactional
	@Override
	public List<Blog> getThreeImportantLatestBlog() {
		Session session = sessionFactory.getCurrentSession();
		Query<Blog> query = session.createQuery("from Blog b where b.isImportant=1 order by b.time desc", Blog.class).setMaxResults(3);
		List<Blog> blogList = query.getResultList();
		
		countComments(blogList, session);
		
		return blogList;
	}

	@Transactional
	@Override
	public List<Blog> getLatestBlog(int limit) {
		Session session = sessionFactory.getCurrentSession();
		Query<Blog> query = session.createQuery("from Blog b order by b.time desc", Blog.class).setMaxResults(limit);
		List<Blog> blogList = query.getResultList();
		
		countComments(blogList, session);
		
		return blogList;
	}
	


	@Transactional
	@Override
	public List<Blog> getThreeBestVisitBlog() {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Blog b where b.time between :last and :now order by b.numberOfViews desc").setMaxResults(3);
		
		Timestamp now = new Timestamp(System.currentTimeMillis());
		
		LocalDateTime time = LocalDateTime.now().minusDays(30);
		Timestamp last = Timestamp.valueOf(time);
		
		
		query.setParameter("now", now);
		query.setParameter("last",last);
		
		List<Blog> blogList = query.getResultList();
		
		countComments(blogList, session);
		
		
		return blogList;
	}
	
	
	@Transactional
	@Override
	public List<Blog> getAllBlogByAuthor(String authorName) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Blog b where b.author.name=:name and b.author.surname=:surname");
		
		String[] param = authorName.split("-");
		
		query.setParameter("name", param[0]);
		query.setParameter("surname", param[1]);
		
		List<Blog> blogList = query.getResultList();
		
		countComments(blogList, session);
		
		return blogList;
	}
	
	
	@Transactional
	@Override
	public List<Blog> getAllBlogByCategory(String categoryUrl) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Blog b where b.category.categoryUrl=:categoryUrl");
		query.setParameter("categoryUrl", categoryUrl);
		
		List<Blog> blogList = query.getResultList();
		
		countComments(blogList, session);
		
		return blogList;
	}

	
	@Transactional
	@Override
	public Blog getNextBlog(Timestamp time) {
		Blog blog = null;
		Session session = sessionFactory.getCurrentSession();
		Query<Blog> query = session.createQuery("from Blog b where b.time > :time order by b.time", Blog.class).setMaxResults(1);
		query.setParameter("time", time);
		try {
			blog = query.getSingleResult();
		} catch (Exception e) {
		}
		
		return blog;
	}
	
	@Transactional
	@Override
	public Blog getPreviousBlog(Timestamp time) {
		Blog blog = null;
		Session session = sessionFactory.getCurrentSession();
		Query<Blog> query = session.createQuery("from Blog b where b.time < :time order by b.time desc", Blog.class).setMaxResults(1);
		query.setParameter("time", time);
		try {
			blog = query.getSingleResult();
		} catch (Exception e) {
		}
		return blog;
	}
	
	@Transactional
	@Override
	public List<Blog> getSearchBlog(String search) {
		List<Blog> searchList = new ArrayList<Blog>();
		
		
		Session session = sessionFactory.getCurrentSession();
		Query<Blog> queryTitle = session.createQuery("from Blog b where b.title like :searchTerm", Blog.class);
		Query<Blog> queryDescription = session.createQuery("from Blog b where b.description like :searchTerm", Blog.class);
		Query<Blog> queryText = session.createQuery("from Blog b where b.text like :searchTerm", Blog.class);
		
		String searchTerm = "%"+search+"%";
		
		queryTitle.setParameter("searchTerm", searchTerm);
		queryDescription.setParameter("searchTerm", searchTerm);
		queryText.setParameter("searchTerm", searchTerm);
		try {
			searchList.addAll(queryTitle.getResultList());
			searchList.addAll(queryDescription.getResultList());
			searchList.addAll(queryText.getResultList());
			
			countComments(searchList, session);
			
		}catch (Exception e) {
			
		}
		
		
		
		return searchList;
	}
	
	
	// method for count number of comments
	private void countComments(List<Blog> blogList, Session session) {
		for(Blog blog : blogList) {
			Query queryCount = session.createQuery("select count(*) from Comment c where c.enabled=1 and c.blog.id=:id");

			queryCount.setParameter("id", blog.getId());
			
			blog.setNumberOfComment((long) queryCount.uniqueResult());
		}
	}



}


