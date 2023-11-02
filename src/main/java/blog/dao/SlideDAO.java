package blog.dao;

import java.util.List;

import blog.entity.Slide;

public interface SlideDAO {

	public List<Slide> getSlideList();
	
	public Slide getSlide(int id);
	
	public void saveSlide(Slide slide);
	
	public void deleteSlide(int id);
	
	public void getEnabledSlide(int id);
	
	public List<Slide> getSlideListForIndexPage();
}

