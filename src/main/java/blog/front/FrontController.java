package blog.front;

import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import blog.dao.BlogDAO;
import blog.dao.CategoryDAO;
import blog.dao.CommentDAO;
import blog.dao.MessageDAO;
import blog.dao.SlideDAO;
import blog.dao.TagDAO;
import blog.entity.Blog;
import blog.entity.Comment;
import blog.entity.Message;
import blog.entity.Tag;

@Controller
@RequestMapping("/")
public class FrontController {

	@Autowired
	private SlideDAO slideDAO;
	
	@Autowired
	private BlogDAO blogDAO;
	
	@Autowired
	private CategoryDAO categoryDAO;
	
	@Autowired
	private MessageDAO messageDAO;
	
	@Autowired
	private TagDAO tagDAO;
	
	@Autowired
	private CommentDAO commentDAO;
	
	
	/*
	 * HOME PAGE
	 */
	
	@RequestMapping({"/", "/home"})
	public String getIndexPage(Model model) {
		
		List<Blog> importantBlogList = blogDAO.getThreeImportantLatestBlog();
 		
 		// count timeAgo
 		for(Blog blog: importantBlogList) {
 			LocalDateTime time = blog.getTime().toLocalDateTime();
 			blog.setTimeAgo(calcDate(time));
		}
 		
 		model.addAttribute("threeImportantBlog", importantBlogList);
 		model.addAttribute("slideList", slideDAO.getSlideListForIndexPage());
		model.addAttribute("twelveLatestBlog", blogDAO.getLatestBlog(12));
		
		//footer
		model.addAttribute("threeLatestBlog", blogDAO.getLatestBlog(3));
		model.addAttribute("fourImportantCategory", categoryDAO.getFourImportantCategory());
		
		return "front/index-page";
	}
	

	/*
	 * BLOG PAGE
	 */
	
	
	@RequestMapping({"/blog", "/blog/page/{pageId}"})
	public String getBlogPage(@PathVariable(required = false) String pageId,  HttpServletRequest request,  Model model) {
		
		String path=null;
		int pageInd= 0;
		
		return getPage(pageId, request, model, path, pageInd);	
		
	}
	
	
	// get blog by author
	
	@RequestMapping({"/author/{authorName}", "/author/{authorName}/page/{pageId}"})
	public String getBlogPageByAuthor(@PathVariable String authorName,  @PathVariable(required = false) String pageId,  HttpServletRequest request,  Model model) {
		
		int pageInd= 1;
		
		return getPage(pageId, request, model, authorName, pageInd);	
		
	}
	
	// get blog by category
	
	@RequestMapping({"/category/{name}", "/category/{name}/page/{pageId}"})
	public String getBlogPageByCategory(@PathVariable String name,  @PathVariable(required = false) String pageId,  HttpServletRequest request,  Model model) {
		
		int pageInd= 2;
		
		return getPage(pageId, request, model, name, pageInd);	
		
	}
	
	
	// get blog by category
	
	@RequestMapping({"/tag/{name}", "/tag/{name}/page/{pageId}"})
	public String getBlogPageByTag(@PathVariable String name,  @PathVariable(required = false) String pageId,  HttpServletRequest request,  Model model) {
		
		int pageInd= 3;
		
		return getPage(pageId, request, model, name, pageInd);	
		
	}
	
	//search blog
	@RequestMapping({"/blog-search", "/blog-search/page/{pageId}"})
	public String getSearchBlog(@RequestParam(name="search") String searchTerm, @PathVariable(required = false) String pageId, HttpServletRequest request, Model model) {
		
		int pageInd=4;
		
		return getPage(pageId, request, model, searchTerm, pageInd);	
	}

	
	
	/*
	 *  CONTACT PAGE
	 */
	
	@RequestMapping("/contact") 
	public String getContactPage(Model model) {
		model.addAttribute("message", new Message());
		
		//footer
		model.addAttribute("threeLatestBlog", blogDAO.getLatestBlog(3));
		model.addAttribute("fourImportantCategory", categoryDAO.getFourImportantCategory());
		
		return "front/contact-page";
	}
	
	@RequestMapping("/message-save")
	public String saveMessage(@Valid @ModelAttribute Message message, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
		if(result.hasErrors()) {
			
			//footer
			model.addAttribute("threeLatestBlog", blogDAO.getLatestBlog(3));
			model.addAttribute("fourImportantCategory", categoryDAO.getFourImportantCategory());
			
			return "front/contact-page";
		}
		Date date = new Date();
		Timestamp time = new Timestamp(date.getTime());
		message.setTime(time);
		messageDAO.saveMessage(message);
		redirectAttributes.addFlashAttribute("status", "The message has been successfully send");
		
		return "redirect:/contact";
	}
	
	
	/*
	 * BLOG POST
	 * 
	 */
	
	@RequestMapping("/{path}")
	public String getBlogPost(@PathVariable String path,  Model model) {
		
	
		blogDAO.incrementViews(path);
		
		Blog blog = blogDAO.getBlogWithCommentsAndTags(path);
		model.addAttribute("blog", blog);
		
		LocalDateTime time = blog.getTime().toLocalDateTime();
		model.addAttribute("timeAgo", calcDate(time));

		
		model.addAttribute("comment", new Comment());
		
		Blog nextBlog = blogDAO.getNextBlog(blog.getTime());
		Blog prevBlog = blogDAO.getPreviousBlog(blog.getTime());
		
		//set previous and nex blog
		model.addAttribute("prevBlog", prevBlog);
		model.addAttribute("nextBlog", nextBlog);
		
		// aside
		model.addAttribute("thereVisitedBlog", blogDAO.getThreeBestVisitBlog());
		model.addAttribute("categoryList", categoryDAO.getCategoryList());
		model.addAttribute("tagList", tagDAO.getTagListWithBlogs());
		
		//footer
		model.addAttribute("threeLatestBlog", blogDAO.getLatestBlog(3));
		model.addAttribute("fourImportantCategory", categoryDAO.getFourImportantCategory());
		
		return "front/blog-post-page";
	}
	
	
	@RequestMapping("/comment-save")
	public String getSaveComment(@Valid @ModelAttribute Comment comment, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
		
		if(result.hasErrors()) {
			
			// aside
			model.addAttribute("thereVisitedBlog", blogDAO.getThreeBestVisitBlog());
			model.addAttribute("categoryList", categoryDAO.getCategoryList());
			model.addAttribute("tagList", tagDAO.getTagListWithBlogs());
			
			//footer
			model.addAttribute("threeLatestBlog", blogDAO.getLatestBlog(3));
			model.addAttribute("fourImportantCategory", categoryDAO.getFourImportantCategory());
			
			
			
			return "front/blog-post-page";
		}
		
		
		comment.setTime(Timestamp.valueOf(LocalDateTime.now()));
		comment.setEnabled(true);
		
		
		
		System.out.println("PROVJRA BLOG U KOMENTARU: "+ comment.getBlog().getBlogUrl());
		
		commentDAO.saveComment(comment);
		
		String path= "redirect:/"+comment.getBlog().getBlogUrl();
		
		return path;
	}
	
	
	
	// get blogs by author, category, tags and 12 latest
	
	private String getPage(String pageId,  HttpServletRequest request,  Model model, String path, int pageInd) {
		
		PagedListHolder<Blog> blogList;
		Tag tag = null;
		
		// setup pagination
		if(pageId==null) {
			
			blogList = new PagedListHolder<Blog>();
			List<Blog> blogs;
			
			// get blogs by pageInd (12 latest (0, default), author (1), category(2), tag(3), search(4))
			switch (pageInd) {
				case 4:
					// get blogs by search
					blogs = blogDAO.getSearchBlog(path);
					// count timeAgo
			 		for(Blog blog: blogs) {
			 			LocalDateTime time = blog.getTime().toLocalDateTime();
			 			blog.setTimeAgo(calcDate(time));
					}
			 		
					break;
				case 3:
					// get blogs by tag
					 tag = tagDAO.getTagWithBlogs(path);
					blogs = tag.getBlogs();
					// count timeAgo
			 		for(Blog blog: blogs) {
			 			LocalDateTime time = blog.getTime().toLocalDateTime();
			 			blog.setTimeAgo(calcDate(time));
					}
				
					break;
				case 2:
					// get blogs by category
					blogs = blogDAO.getAllBlogByCategory(path);
					// count timeAgo
			 		for(Blog blog: blogs) {
			 			LocalDateTime time = blog.getTime().toLocalDateTime();
			 			blog.setTimeAgo(calcDate(time));
					}
					break;
				case 1:
					// get blogs by author
					blogs = blogDAO.getAllBlogByAuthor(path);
					// count timeAgo
			 		for(Blog blog: blogs) {
			 			LocalDateTime time = blog.getTime().toLocalDateTime();
			 			blog.setTimeAgo(calcDate(time));
					}
					break;

				case 0:
			    default:
			    	//  get latest 12 blogs  
					blogs =  blogDAO.getLatestBlog(12);
					// count timeAgo
			 		for(Blog blog: blogs) {
			 			LocalDateTime time = blog.getTime().toLocalDateTime();
			 			blog.setTimeAgo(calcDate(time));
					}
					break;
			}
			
			blogList.setSource(blogs);
			blogList.setPageSize(4);
			
			request.getSession().setAttribute("blogList", blogList);
		}
		else if(pageId.equals("next")) {
			blogList = (PagedListHolder<Blog>) request.getSession().getAttribute("blogList");
			blogList.nextPage();
		}
		else if(pageId.equals("prev")) {
			blogList = (PagedListHolder<Blog>) request.getSession().getAttribute("blogList");
			blogList.previousPage();
		}
		else {
			int ind=Integer.parseInt(pageId);
			blogList = (PagedListHolder<Blog>) request.getSession().getAttribute("blogList");
			blogList.setPage(ind-1);
		}
		
		// set page identifikator
		switch (pageInd) {
		case 4:
			//page identifikator
			model.addAttribute("pageId", "search");
			
			//search term
			model.addAttribute("searchTerm", path);
			break;
		case 3:
			//page identifier
			model.addAttribute("pageId", "tag");
			
			//tag
			model.addAttribute("tag", tag);
			break;

		case 2:
			//page identifier
			model.addAttribute("pageId", "category");
	
			//category name
			model.addAttribute("category", blogList.getSource().get(0).getCategory());
			break;

		case 1:
			//page identifier
			model.addAttribute("pageId", "author");
			
			//author
			model.addAttribute("author", blogList.getSource().get(0).getAuthor());
			break;

		case 0:
		default:
			//page identifier
			model.addAttribute("pageId", "blog");
			break;
	}
		
		
		// aside
		model.addAttribute("thereVisitedBlog", blogDAO.getThreeBestVisitBlog());
		model.addAttribute("categoryList", categoryDAO.getCategoryList());
		model.addAttribute("tagList", tagDAO.getTagListWithBlogs());
		
		//footer
		model.addAttribute("threeLatestBlog", blogDAO.getLatestBlog(3));
		model.addAttribute("fourImportantCategory", categoryDAO.getFourImportantCategory());	
		
		return "front/blog-page";
	}
	
	
	// method for calculating how many time ago blog  was posted
	private String calcDate(LocalDateTime blogTime) {
		LocalDateTime current = LocalDateTime.now();
		
		Duration duration = Duration.between(blogTime, current);
		
		if(duration.toDays()/31/12 == 0) {
			if(duration.toDays()/31 == 0) {
				if(duration.toDays() == 0) {
					if(duration.toHours() == 0) {
						if(duration.toMinutes() == 0) {
							return duration.getSeconds() + "second ago";
						}else
							return duration.toMinutes() +" minute ago";
					}else
						return duration.toHours()+ "hour ago";
				}else
					return duration.toDays()+" day ago";
			}else
				return duration.toDays()/31 + " month ago";
		}else
			return duration.toDays()/31/12 + " year ago";
		
	}
	
}
