package blog.backend;



import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import blog.dao.BlogDAO;
import blog.dao.CategoryDAO;
import blog.dao.CommentDAO;
import blog.dao.MessageDAO;
import blog.dao.SlideDAO;
import blog.dao.TagDAO;
import blog.dao.UserDAO;
import blog.entity.Blog;
import blog.entity.Category;
import blog.entity.ChangePassword;
import blog.entity.Comment;
import blog.entity.Message;
import blog.entity.Slide;
import blog.entity.Tag;
import blog.entity.User;

@Controller
@RequestMapping("/administration")
public class AdministrationController {

	@Autowired
	private TagDAO tagDAO;
	
	@Autowired
	private CategoryDAO categoryDAO;
	
	@Autowired
	private SlideDAO slideDAO;
	
	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private BlogDAO blogDAO;
	
	@Autowired
	private MessageDAO messageDAO;
	
	@Autowired
	private CommentDAO commentDAO;
	
	/*
	 * TAG CONTROLLER
	 */
	
	// get all tags
	@RequestMapping("/tag-list")
	public String getTagList(Model model) {
		List<Tag> tagList = tagDAO.getTagList();
		
		getUserDetail(model);
		
		model.addAttribute("tagList", tagList);
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "tag-list";
	}
	
	//get tag form
	@RequestMapping("/tag-form")
	public String getTagForm(Model model) {
		Tag tag = new Tag();
		
		getUserDetail(model);
		
		model.addAttribute("tag", tag);
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "tag-form";
	}
	
	//save tag
	@RequestMapping("/tag-save")
	public String getSaveTag(@Valid @ModelAttribute Tag tag, BindingResult result, Model model) {
		
		if(result.hasErrors()) {
			
			getUserDetail(model);
			
			model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
			
			return "tag-form";
		}
		
		// set tag url
		String url = tag.getName().toLowerCase().replaceAll("[\\W]+", "-");
		tag.setTagUrl(url);
		
		tagDAO.saveTag(tag);
		return "redirect:/administration/tag-list";
	}
	
	//update tag
	@RequestMapping("/tag-update-form")
	public String getTagUpdateForm(@RequestParam int id, Model model) {
		Tag tag = tagDAO.getTag(id);
		getUserDetail(model);
		
		model.addAttribute("tag", tag);
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "tag-form";
	}
	
	//delete tag
	@RequestMapping("/tag-delete")
	public String getDeleteTag(@RequestParam int id) {
		tagDAO.deleteTag(id);
		
		return "redirect:/administration/tag-list";
	}
	
	
	/*
	 * CATEGORY CONTROLLER
	 */
	
	//get all category
	@RequestMapping("/category-list")
	public String getCategoryList(Model model) {
		List<Category> categoryList = categoryDAO.getCategoryList();
		
		getUserDetail(model);
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
 		return "category-list";
	}
	
	//get category form
	@RequestMapping("/category-form")
	public String getCategoryForm(Model model) {
		Category category = new Category();
		getUserDetail(model);
		
		model.addAttribute("category", category);
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "category-form";
	}
	
	//save category
	@RequestMapping("/category-save")
	public String getSaveCategory(@Valid @ModelAttribute Category category, BindingResult result, Model model) {
		
		if(result.hasErrors()) {
			getUserDetail(model);
			
			model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
			
			return "category-form";
		}
		
		// set category url
		String url = category.getName().toLowerCase().replaceAll("[\\W]+", "-");
		category.setCategoryUrl(url);
		
		categoryDAO.saveCategory(category);
		
		return "redirect:/administration/category-list";
	}
	
	//update category
	@RequestMapping("/category-update-form")
	public String getCategoryUpdateForm(@RequestParam int id, Model model) {
		Category category = categoryDAO.getCategory(id);
		getUserDetail(model);
		
		model.addAttribute("category", category);
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "category-form";
	}
	
	//delete category
	@RequestMapping("/category-delete")
	public String getDeleteCategory(@RequestParam int id) {
		categoryDAO.deleteCategory(id);
		
		return "redirect:/administration/category-list";
	}
	
	
	/*
	 * SLIDE CONTROLLER
	 */
	
	// get all slides
	@RequestMapping("/slide-list")
	public String getSlideList(Model model) {
		List<Slide> slideList = slideDAO.getSlideList();
		getUserDetail(model);
		
		model.addAttribute("slideList", slideList);
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "slide-list";
	}
	
	//get slide form
	@RequestMapping("/slide-form")
	public String getSlideForm(Model model) {
		Slide slide = new Slide();
		getUserDetail(model);
		
		model.addAttribute("slide", slide);
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "slide-form";
	}
	
	//save slide
	@RequestMapping("/slide-save")
	public String getSaveSlide(@Valid @ModelAttribute Slide slide, BindingResult result, 
							   @RequestParam("file") MultipartFile multipartFile, HttpSession session, Model model) throws IOException {
		
		if(multipartFile.isEmpty()) {
			if(slide.getImage().isEmpty())
				result.addError(null);
		}else {
			String img = uploadImage(multipartFile, session);
			slide.setImage(img);
		}
		
		if(result.hasErrors()) {
			getUserDetail(model);
			
			model.addAttribute("errorImage", "Image is required");
			model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
			
			return "slide-form";
		}
		
		if(slide.getButtonUrl().startsWith("/") ) {
			slide.setButtonUrl(slide.getButtonUrl().substring(1));
		}
		
		slideDAO.saveSlide(slide);
		return "redirect:/administration/slide-list";
	}
	
	
	//update slide
	@RequestMapping("/slide-update-form")
	public String getSlideUpdateForm(@RequestParam int id, Model model) {
		Slide slide = slideDAO.getSlide(id);
		getUserDetail(model);
		
		model.addAttribute("slide", slide);
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "slide-form";
	}
	
	//delete slide
	@RequestMapping("/slide-delete")
	public String getDeleteSlide(@RequestParam int id) {
		slideDAO.deleteSlide(id);
		
		return "redirect:/administration/slide-list";
	}
	
	// set is enabled
	@RequestMapping("/slide-enabled")
	private String getEnabledSlide(@RequestParam int id) {
		slideDAO.getEnabledSlide(id);
		
		return "redirect:/administration/slide-list";
	}
	
	
	/*
	 * USER CONTROLLER
	 */
	
	// get all users
	@RequestMapping("/user-list")
	public String getUserList(Model model) {
		List<User> userList = userDAO.getUserList();
		getUserDetail(model);
		
		model.addAttribute("userList", userList);
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "user-list";
	}
	
	//get user form
	@RequestMapping("/user-form")
	public String getUserForm(Model model) {
		User user = new User();
		getUserDetail(model);
        
		model.addAttribute("user", user);
		model.addAttribute("roleList", userDAO.getRoleList());
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "user-form";
	}
	
	//save user
	@RequestMapping("/user-save")
	public String getSaveUser(@Valid @ModelAttribute User user, BindingResult result, 
							  @RequestParam("file") MultipartFile multipartFile,  
							  HttpSession session, Model model) throws IOException{
		
		if(result.hasErrors()) {
			getUserDetail(model);
			
			model.addAttribute("roleList", userDAO.getRoleList());
			model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
			return "user-form";
		}
		
		// set password
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		String password = encoder.encode(user.getPassword());
		user.setPassword("{bcrypt}" + password);
		
		
		//set image
		if(!multipartFile.isEmpty()) {
			String img = uploadImage(multipartFile, session);
			user.setImage(img);
		}
		
		userDAO.saveUser(user);
		return "redirect:/administration/user-list";
	}
	
	
	//delete user
	@RequestMapping("/user-delete")
	public String getDeleteUser(@RequestParam String username) {
		userDAO.deleteUser(username);
		
		return "redirect:/administration/user-list";
	}
	
	// set is enabled
	@RequestMapping("/user-enabled")
	private String getEnabledSlide(@RequestParam String username) {
		userDAO.getEnabledUser(username);
			
		return "redirect:/administration/user-list";
	}
	
	
	//edit profile
	@RequestMapping("/user-edit-profile")
	private String getUserEditProfile(Model model, HttpServletRequest request) {
	
		
		getUserDetail(model);
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "user-edit-profile";
	}
	
	//save user
    @RequestMapping("/user-edit-save")
	public String getUserEditSave(@Valid @ModelAttribute("loggedUser") User user, BindingResult result, 
				  				  @RequestParam("file") MultipartFile multipartFile,  
				  				  HttpSession session, Model model) throws IOException {
			
		if(result.hasErrors()) {
			getUserDetail(model);
			System.out.println("-----------GRESKA-------");
			System.out.println(result.getAllErrors());
			model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
			return "user-edit-profile";
		}
		
		//set image
		if(!multipartFile.isEmpty()) {
			String img = uploadImage(multipartFile, session);
			user.setImage(img);
			System.out.println("-----------POSTAVLJeNA SLIKA-------");
		}
			
		System.out.println("IMG:" + user.getImage());
		userDAO.saveUser(user);
		return "redirect:/administration/user-edit-profile";
	}
	
	// get change password jsp
	@RequestMapping("/change-password-form")
	private String getChangePasswordForm(Model model) {
		getUserDetail(model);
		model.addAttribute("changePassword", new ChangePassword());
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "user-change-password";
	}
	
	// change password
	@RequestMapping("/change-password")
	private String getChangePassword(@Valid @ModelAttribute ChangePassword changePassword, BindingResult result,Model model, Principal principal, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		User user = userDAO.getUser(principal.getName());
		
		if(encoder.matches(changePassword.getOldPassword(), user.getPassword().replace("{bcrypt}", ""))) {
			
			if(result.hasErrors()) {
				
				model.addAttribute("loggedUser", user);
				model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
				
				return "user-change-password";
			}
			user.setPassword("{bcrypt}"+encoder.encode(changePassword.getNewPassword()));
			userDAO.saveUser(user);
			
	
			redirectAttributes.addFlashAttribute("status", "The password has been successfully changed");
			
			return "redirect:/administration/user-edit-profile";
		}else {
			model.addAttribute("loggedUser", user);
			model.addAttribute("messageError", "Check your password");
			model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
			
			return "user-change-password";
			
		}
		
	}
	
	
	/*
	 * BLOG CONTROLLER
	 */
	
	// get all blogs
	@RequestMapping({"/", "/blog-list"})
	public String getBlogList(Model model) {
		List<Blog> blogList = blogDAO.getBlogList();
		getUserDetail(model);
		
		model.addAttribute("blogList", blogList);
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "blog-list";
	}
	
	//get blog form
	@RequestMapping("/blog-form")
	public String getBlogForm(Model model) {
		Blog blog = new Blog();
		
        
		//set time
		Date date = new Date();
		Timestamp time = new Timestamp(date.getTime());
		blog.setTime(time);
		
		getUserDetail(model);
		
		
		model.addAttribute("blog", blog);
		model.addAttribute("categoryList", categoryDAO.getCategoryList());
		model.addAttribute("authorList", userDAO.getUserList());
		model.addAttribute("tagList", tagDAO.getTagList());
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "blog-form";
	}	
	
	//save blog
	@RequestMapping("/blog-save")
	public String getSaveBlog(@Valid @ModelAttribute Blog blog, BindingResult result, 
							  @RequestParam("file") MultipartFile multipartFile,  
							  @RequestParam("secondFile") MultipartFile multipartSecondFile,  
							  HttpSession session, Model model) throws IOException {
		
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = userDAO.getUser(authentication.getName());
		
		
		if(multipartFile.isEmpty()) {
			if(blog.getImage().isEmpty())
				result.addError(null);
		}
		else {
			//set main image
			String img = uploadImage(multipartFile, session);
			blog.setImage(img);
		}
		
		if(result.hasErrors()) {
			
			model.addAttribute("loggedUser", user);
			
			model.addAttribute("errorImage", "Image is required");
			model.addAttribute("categoryList", categoryDAO.getCategoryList());
			model.addAttribute("authorList", userDAO.getUserList());
			model.addAttribute("tagList", tagDAO.getTagList());
			model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
			
			return "blog-form";
		}

		
		// set author
		blog.setAuthor(user);
		
		// set category
		Category category = categoryDAO.getCategory(blog.getCategory().getId());
		blog.setCategory(category);
		
		// set tags
		List<Integer> ids = new ArrayList<>();
		for(Tag tag: blog.getTags()) {
			ids.add(Integer.parseInt(tag.getName()));
		}
		List<Tag> tags = tagDAO.getAllTagById(ids);
		blog.setTags(tags);
		
		// set blog url
		String url = blog.getTitle().toLowerCase().replaceAll("[\\W]+", "-");
		blog.setBlogUrl(url);
		
		//set time
		Date date = new Date();
		Timestamp time = new Timestamp(date.getTime());
		blog.setTime(time);
		
		//set second image
		if(!multipartSecondFile.isEmpty()) {
			
			String img = uploadImage(multipartSecondFile, session);
			
			blog.setSecondImage(img);
		}
		
		
		blogDAO.saveBlog(blog);
		return "redirect:/administration/blog-list";
	}
	
	//update blog
	@RequestMapping("/blog-update-form")
	public String getBlogUpdateForm(@RequestParam int id, Model model) {
		Blog blog = blogDAO.getBlogWithTags(id);
		getUserDetail(model);
		
		model.addAttribute("blog", blog);
		model.addAttribute("categoryList", categoryDAO.getCategoryList());
		model.addAttribute("authorList", userDAO.getUserList());
		model.addAttribute("tagList", tagDAO.getTagList());
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "blog-form";
	}
	
	//delete blog
	@RequestMapping("/blog-delete")
	public String getDeleteBlog(@RequestParam int id) {
		blogDAO.deleteBlog(id);
		
		return "redirect:/administration/blog-list";
	}
	
	// set is important blog
	@RequestMapping("/blog-is-important")
	private String getIsImportantBlog(@RequestParam int id) {
		blogDAO.setImportantBlog(id);
		return "redirect:/administration/blog-list";
	}
	
	
	/*
	 * MESSAGE CONTROLLER
	 */
	
	// get all message
	@RequestMapping("/message-list")
	public String getMessageList(Model model) {
		List<Message> messageList = messageDAO.getMessageList();
		getUserDetail(model);
		
		model.addAttribute("messageList", messageList);
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "message-list";
	}
	
	//delete message
	@RequestMapping("/message-delete")
	public String getDeleteMessage(@RequestParam int id) {
		messageDAO.deleteMessage(id);
		
		return "redirect:/administration/message-list";
	}
	
	// isSeen
	@RequestMapping("/message-is-seen")
	public String getIsSeenMessage(@RequestParam int id) {
		messageDAO.isSeenMessage(id);
		
		return "redirect:/administration/message-list";
	}
	
	
	/*
	 * COMMENT CONTROLLER
	 */
	
	// get all comment
	@RequestMapping("/comment-list")
	public String getCommentList(Model model) {
		List<Comment> commentList = commentDAO.getCommentList();
		getUserDetail(model);
		
		model.addAttribute("commentList", commentList);
		model.addAttribute("messageCount", messageDAO.getUnreadMessageCount());
		
		return "comment-list";
	}
	
	//delete comment
	@RequestMapping("/comment-delete")
	public String getDeleteComment(@RequestParam int id) {
		commentDAO.deleteComment(id);
		
		return "redirect:/administration/comment-list";
	}
	
	// isEnabled
	@RequestMapping("/comment-enabled")
	public String getIsEnabledComment(@RequestParam int id) {
		commentDAO.isEnabledComment(id);
		
		return "redirect:/administration/comment-list";
	}
	
	
	
	
	
	
	
	
	
	
	private String uploadImage(MultipartFile multipartFile, HttpSession session) throws IOException {
		//set image
		byte[] data = multipartFile.getBytes();
		
		String filePath = session.getServletContext().getRealPath("/")  + File.separator + "resources"
						+ File.separator + "img" + File.separator + multipartFile.getOriginalFilename();
		try {
            FileOutputStream fileout  = new FileOutputStream(filePath);
            fileout.write(data);
  
            fileout.close();
        }catch (Exception e) {
            e.printStackTrace();
        }
		
		System.out.println("----------- SLIKA-------");
		return "img/"+multipartFile.getOriginalFilename();
	}

	
	private void getUserDetail(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		
		User user = userDAO.getUser(authentication.getName());
		
		model.addAttribute("loggedUser", user);
	}
}
