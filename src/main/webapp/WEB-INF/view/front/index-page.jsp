<%@page import="org.springframework.web.bind.annotation.RequestAttribute"%>
<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Bootstrap Blog - B4 Template by Bootstrap Temple</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="vendor/font-awesome/css/font-awesome.min.css">
    <!-- Custom icon font-->
    <link rel="stylesheet" href="css/fontastic.css">
    <!-- Google fonts - Open Sans-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
    <!-- Fancybox-->
    <link rel="stylesheet" href="vendor/@fancyapps/fancybox/jquery.fancybox.min.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="css/custom.css">
    <!-- Favicon-->
    <link rel="shortcut icon" href="favicon.png">
    <!-- Tweaks for older IEs--><!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]--> 
    <!-- owl carousel 2 stylesheet-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/owl-carousel2/assets/owl.carousel.min.css" id="theme-stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/owl-carousel2/assets/owl.theme.default.min.css" id="theme-stylesheet">
  </head>
  <body>
    <header class="header">
      <!-- Main Navbar-->
      <nav class="navbar navbar-expand-lg">
        <div class="search-area">
          <div class="search-area-inner d-flex align-items-center justify-content-center">
            <div class="close-btn"><i class="icon-close"></i></div>
            <div class="row d-flex justify-content-center">
              <div class="col-md-8">
                <form action="blog-search">
                  <div class="form-group">
                    <input type="search" name="search" id="search" placeholder="What are you looking for?">
                    <button type="submit" class="submit"><i class="icon-search-1"></i></button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
        <div class="container">
          <!-- Navbar Brand -->
          <div class="navbar-header d-flex align-items-center justify-content-between">
            <!-- Navbar Brand --><a href="home" class="navbar-brand">Bootstrap Blog</a>
            <!-- Toggle Button-->
            <button type="button" data-toggle="collapse" data-target="#navbarcollapse" aria-controls="navbarcollapse" aria-expanded="false" aria-label="Toggle navigation" class="navbar-toggler"><span></span><span></span><span></span></button>
          </div>
          <!-- Navbar Menu -->
          <div id="navbarcollapse" class="collapse navbar-collapse">
            <ul class="navbar-nav ml-auto">
              <li class="nav-item"><a href="home" class="nav-link active">Home</a>
              </li>
              <li class="nav-item"><a href="blog" class="nav-link">Blog</a>
              </li>
              <li class="nav-item"><a href="contact" class="nav-link">Contact</a>
              </li>
            </ul>
            <div class="navbar-text"><a href="#" class="search-btn"><i class="icon-search-1"></i></a></div>
          </div>
        </div>
      </nav>
    </header>

    <!-- Hero Section-->
    <div id="index-slider" class="owl-carousel">
      <c:forEach var="slide" items="${slideList}">
        <section style="background: url(${slide.image}); background-size: cover; background-position: center center" class="hero">
        <div class="container">
          <div class="row">
            <div class="col-lg-7">
              <h1>${slide.title }</h1>
              <a href="${slide.buttonUrl }" class="hero-link">${slide.buttonTitle}</a>
            </div>
          </div>
        </div>
      </section>
      </c:forEach>
      
    </div>

    <!-- Intro Section-->
    <section class="intro">
      <div class="container">
        <div class="row">
          <div class="col-lg-8">
            <h2 class="h3">Some great intro here</h2>
            <p class="text-big">Place a nice <strong>introduction</strong> here <strong>to catch reader's attention</strong>.</p>
          </div>
        </div>
      </div>
    </section>
    <section class="featured-posts no-padding-top">
      <div class="container">
        
        <c:forEach var="i" begin="0" end="${threeImportantBlog.size()-1}">
        	<c:if test="${i%2==0 }">
        	  <!-- Post-->
	          <div class="row d-flex align-items-stretch">
	            <div class="text col-lg-7">
	              <div class="text-inner d-flex align-items-center">
	                <div class="content">
	                  <header class="post-header">
	                  
	                    <div class="category">
                          <c:if test="${threeImportantBlog[i].category.name != null}">
                            <a href="category/${threeImportantBlog[i].category.categoryUrl}">${threeImportantBlog[i].category.name}</a>
                          </c:if>
                          <c:if test="${threeImportantBlog[i].category.name == null}">
                            <a>Uncategorized</a>
                          </c:if>
                        </div>
                      
	                    <a href="${threeImportantBlog[i].blogUrl}">
	                      <h2 class="h4">${threeImportantBlog[i].title}</h2>
	                    </a>
	                    
	                  </header>
	                  <p>${threeImportantBlog[i].description}</p>
	                  <footer class="post-footer d-flex align-items-center">
	                    <a href="author/${threeImportantBlog[i].author.name}-${threeImportantBlog[i].author.surname}" class="author d-flex align-items-center flex-wrap">
	                      <div class="avatar"><img src="${threeImportantBlog[i].author.image}" alt="..." class="img-fluid"></div>
	                      <div class="title"><span>${threeImportantBlog[i].author.name} ${threeImportantBlog[i].author.surname}</span></div>
	                    </a>
	                    <div class="date"><i class="icon-clock"></i>${threeImportantBlog[i].timeAgo}</div>
	                    <div class="comments"><i class="icon-comment"></i>${threeImportantBlog[i].numberOfComment}</div>
	                  </footer>
	                </div>
	              </div>
	            </div>
	            <div class="image col-lg-5"><img src="${threeImportantBlog[i].image}" alt="..."></div>
	          </div>
        	</c:if>
        	
        	<c:if test="${i%2!=0 }">
        	  <!-- Post        -->
		      <div class="row d-flex align-items-stretch">
		        <div class="image col-lg-5"><img src="${threeImportantBlog[i].image}" alt="..."></div>
		        <div class="text col-lg-7">
		          <div class="text-inner d-flex align-items-center">
		            <div class="content">
		              <header class="post-header">
		             
		                <div class="category">
                          <c:if test="${threeImportantBlog[i].category.name != null}">
                            <a href="category/${threeImportantBlog[i].category.categoryUrl}">${threeImportantBlog[i].category.name}</a>
                          </c:if>
                          <c:if test="${threeImportantBlog[i].category.name == null}">
                            <a>Uncategorized</a>
                          </c:if>
                        </div>
		                
		                <a href="${threeImportantBlog[i].blogUrl}">
		                  <h2 class="h4">${threeImportantBlog[i].title}</h2>
		                </a>
		              </header>
		              <p>${threeImportantBlog[i].description}</p>
		              <footer class="post-footer d-flex align-items-center">
		                <a href="author/${threeImportantBlog[i].author.name}-${threeImportantBlog[i].author.surname}" class="author d-flex align-items-center flex-wrap">
		                  <div class="avatar"><img src="${threeImportantBlog[i].author.image}" alt="..." class="img-fluid"></div>
		                  <div class="title"><span>${threeImportantBlog[i].author.name} ${threeImportantBlog[i].author.surname}</span></div>
		                </a>
		                <div class="date"><i class="icon-clock"></i>${threeImportantBlog[i].timeAgo}</div>
		                <div class="comments"><i class="icon-comment"></i>${threeImportantBlog[i].numberOfComment}</div>
		              </footer>
		            </div>
		          </div>
		        </div>
		      </div>
        	</c:if>
        	
        </c:forEach> 
      </div>
    </section>
    <!-- Divider Section-->
    <section style="background: url(img/divider-bg.jpg); background-size: cover; background-position: center bottom" class="divider">
      <div class="container">
        <div class="row">
          <div class="col-md-7">
            <h2>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua</h2>
            <a href="contact.html" class="hero-link">Contact Us</a>
          </div>
        </div>
      </div>
    </section>
    <!-- Latest Posts -->
    <section class="latest-posts"> 
      <div class="container">
        <header> 
          <h2>Latest from the blog</h2>
          <p class="text-big">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
        </header>
        <div class="owl-carousel" id="latest-posts-slider">
          
          <c:forEach var="i" begin="0" end="3">
            <div class="row">
              <c:forEach var="j" begin="${i*3}" end="${i*3+2}">
                <div class="post col-md-4">
                  <div class="post-thumbnail">
                    <a href="${twelveLatestBlog[j].blogUrl}">
                      <img src="${twelveLatestBlog[j].image}" alt="..." class="img-fluid">
                    </a>
                  </div>
                  <div class="post-details">
                    <div class="post-meta d-flex justify-content-between">
                      <div class="date">
                        <fmt:formatDate pattern = "dd MMMM" value = "${twelveLatestBlog[j].time}" /> | <fmt:formatDate pattern = "yyyy" value = "${twelveLatestBlog[j].time}"/>
                      </div>
                      
                      <div class="category">
                          <c:if test="${twelveLatestBlog[j].category.name != null}">
                            <a href="category/${twelveLatestBlog[j].category.categoryUrl}">${twelveLatestBlog[j].category.name }</a>
                          </c:if>
                          <c:if test="${twelveLatestBlog[j].category.name == null}">
                            <span>Uncategorized</span>
                          </c:if>
                        </div>
                    </div><a href="${twelveLatestBlog[j].blogUrl}">
                      <h3 class="h4">${twelveLatestBlog[j].title }</h3></a>
                    <p class="text-muted">${twelveLatestBlog[j].description }</p>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:forEach>
        </div>
      </div>
    </section>
    <!-- Gallery Section-->
    <section class="gallery no-padding">    
      <div class="row">
        <div class="mix col-lg-3 col-md-3 col-sm-6">
          <div class="item">
            <a href="img/gallery-1.jpg" data-fancybox="gallery" class="image">
              <img src="img/gallery-1.jpg" alt="gallery image alt 1" class="img-fluid" title="gallery image title 1">
              <div class="overlay d-flex align-items-center justify-content-center"><i class="icon-search"></i></div>
            </a>
          </div>
        </div>
        <div class="mix col-lg-3 col-md-3 col-sm-6">
          <div class="item">
            <a href="img/gallery-2.jpg" data-fancybox="gallery" class="image">
              <img src="img/gallery-2.jpg" alt="gallery image alt 2" class="img-fluid" title="gallery image title 2">
              <div class="overlay d-flex align-items-center justify-content-center"><i class="icon-search"></i></div>
            </a>
          </div>
        </div>
        <div class="mix col-lg-3 col-md-3 col-sm-6">
          <div class="item">
            <a href="img/gallery-3.jpg" data-fancybox="gallery" class="image">
              <img src="img/gallery-3.jpg" alt="gallery image alt 3" class="img-fluid" title="gallery image title 3">
              <div class="overlay d-flex align-items-center justify-content-center"><i class="icon-search"></i></div>
            </a>
          </div>
        </div>
        <div class="mix col-lg-3 col-md-3 col-sm-6">
          <div class="item">
            <a href="img/gallery-4.jpg" data-fancybox="gallery" class="image">
              <img src="img/gallery-4.jpg" alt="gallery image alt 4" class="img-fluid" title="gallery image title 4">
              <div class="overlay d-flex align-items-center justify-content-center"><i class="icon-search"></i></div>
            </a>
          </div>
        </div>
        
      </div>
    </section>
    <!-- Page Footer-->
    <footer class="main-footer">
      <div class="container">
        <div class="row">
          <div class="col-md-4">
            <div class="logo">
              <h6 class="text-white">Bootstrap Blog</h6>
            </div>
            <div class="contact-details">
              <p>53 Broadway, Broklyn, NY 11249</p>
              <p>Phone: (020) 123 456 789</p>
              <p>Email: <a href="mailto:info@company.com">Info@Company.com</a></p>
              <ul class="social-menu">
                <li class="list-inline-item"><a href="#"><i class="fa fa-facebook"></i></a></li>
                <li class="list-inline-item"><a href="#"><i class="fa fa-twitter"></i></a></li>
                <li class="list-inline-item"><a href="#"><i class="fa fa-instagram"></i></a></li>
                <li class="list-inline-item"><a href="#"><i class="fa fa-behance"></i></a></li>
                <li class="list-inline-item"><a href="#"><i class="fa fa-pinterest"></i></a></li>
              </ul>
            </div>
          </div>
          <div class="col-md-4">
            <div class="menus d-flex">
              <ul class="list-unstyled">
                <li> <a href="home">Home</a></li>
                <li> <a href="blog">Blog</a></li>
                <li> <a href="contact">Contact</a></li>
                <li> <a href="/BlogProject/administration/blog-list">Login</a></li>
              </ul>
              <ul class="list-unstyled">
                <c:forEach var="category" items="${fourImportantCategory}">
                  <li> <a href="category/${category.categoryUrl}">${category.name}</a></li>
                </c:forEach>
              </ul>
            </div>
          </div>
          <div class="col-md-4">
            <div class="latest-posts">
            
              <c:forEach var="blog" items="${threeLatestBlog}">
                <a href="${blog.blogUrl}" style="display: block;">
                  <div class="post d-flex align-items-center">
                    <div class="image"><img src="${blog.image}" alt="..." class="img-fluid"></div>
                    <div class="title"><strong>${blog.title}</strong>
                      <span class="date last-meta">
                        <fmt:formatDate pattern = "dd MMMM" value = "${blog.time}" />, <fmt:formatDate pattern = "yyyy" value = "${blog.time}"/>
                      </span>
                    </div>
                  </div>
                </a>
              </c:forEach>
              
              
             </div>
          </div>
        </div>
      </div>
      <div class="copyrights">
        <div class="container">
          <div class="row">
            <div class="col-md-6">
              <p>&copy; 2017. All rights reserved. Your great site.</p>
            </div>
            <div class="col-md-6 text-right">
              <p>Template By <a href="https://bootstrapious.com/p/bootstrap-carousel" class="text-white">Bootstrapious</a>
                <!-- Please do not remove the backlink to Bootstrap Temple unless you purchase an attribution-free license @ Bootstrap Temple or support us at http://bootstrapious.com/donate. It is part of the license conditions. Thanks for understanding :)                         -->
              </p>
            </div>
          </div>
        </div>
      </div>
    </footer>
    <!-- JavaScript files-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/popper.js/umd/popper.min.js"> </script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="vendor/@fancyapps/fancybox/jquery.fancybox.min.js"></script>
    <script src="js/front.js"></script>


    <script src="${pageContext.request.contextPath}/plugins/owl-carousel2/owl.carousel.min.js"></script>
    <script>
      $("#index-slider").owlCarousel({
        "items": 1,
        "loop": true,
        "autoplay": true,
        "autoplayHoverPause": true
      });

      $("#latest-posts-slider").owlCarousel({
        "items": 1,
        "loop": true,
        "autoplay": true,
        "autoplayHoverPause": true
      });
    </script>
    
  </body>
</html>