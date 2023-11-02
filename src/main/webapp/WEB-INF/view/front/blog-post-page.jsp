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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/font-awesome/css/font-awesome.min.css">
    <!-- Custom icon font-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontastic.css">
    <!-- Google fonts - Open Sans-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
    <!-- Fancybox-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/@fancyapps/fancybox/jquery.fancybox.min.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/custom.css">
    <!-- Favicon-->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.png">
    <!-- Tweaks for older IEs--><!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
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
                <form action="${pageContext.request.contextPath}/blog-search">
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
              <li class="nav-item"><a href="home" class="nav-link">Home</a>
              </li>
              <li class="nav-item"><a href="blog" class="nav-link active">Blog</a>
              </li>
              <li class="nav-item"><a href="contact" class="nav-link">Contact</a>
              </li>
            </ul>
            <div class="navbar-text"><a href="#" class="search-btn"><i class="icon-search-1"></i></a></div>
          </div>
        </div>
      </nav>
    </header>
    <div class="container">
      <div class="row">
        <!-- Blog Post -->
        <main class="post blog-post col-lg-8"> 
          <div class="container">
            <div class="post-single">
              <div class="post-thumbnail"><img src="${blog.image}" alt="..." class="img-fluid"></div>
              <div class="post-details">
                <div class="post-meta d-flex justify-content-between">
                  <div class="category">
                    <c:if test="${blog.category.name != null}">
                      <a href="category/${blog.category.categoryUrl}">${blog.category.name }</a>
                    </c:if>
                    <c:if test="${blog.category.name == null}">
                      <a>Uncategorized</a>
                    </c:if>
                  </div>
                </div>
                <h1>${blog.title}<a href="#"><i class="fa fa-bookmark-o"></i></a></h1>
                <div class="post-footer d-flex align-items-center flex-column flex-sm-row">
                  <a href="author/${blog.author.name}-${blog.author.surname}" class="author d-flex align-items-center flex-wrap">
                    <div class="avatar"><img src="${blog.author.image}" alt="..." class="img-fluid"></div>
                    <div class="title"><span>${blog.author.name} ${blog.author.surname}</span></div>
                  </a>
                  <div class="d-flex align-items-center flex-wrap">       
                    <div class="date"><i class="icon-clock"></i> ${timeAgo}</div>
                    <div class="views"><i class="icon-eye"></i>${blog.numberOfViews}</div>
                    <div class="comments meta-last"><a href="#post-comments"><i class="icon-comment"></i>${blog.comments.size()}</a></div>
                  </div>
                </div>
                <div class="post-body">
                  <p class="lead">${blog.description}</p>
                  <c:if test="${blog.secondImage != null}">
                    <p> <img src="${blog.secondImage}" alt="..." class="img-fluid"></p>
                  </c:if>
                  <p>${blog.text}</p>
                  </div>
                <div class="post-tags">
                  <c:forEach var="tag" items="${blog.tags}">
                    <a href="tag/${tag.tagUrl }" class="tag">#${tag.name }</a>
                  </c:forEach>
                </div>
                
                <!-- next and previous -->
                <div class="posts-nav d-flex justify-content-between align-items-stretch flex-column flex-md-row">
                  <c:if test="${prevBlog != null }">
                    <a href="${prevBlog.blogUrl}" class="prev-post text-left d-flex align-items-center">
                      <div class="icon prev"><i class="fa fa-angle-left"></i></div>
                      <div class="text">
                        <strong class="text-primary">Previous Post </strong>
                        <h6>${prevBlog.title}</h6>
                      </div>
                    </a>
                  </c:if>
                  
                  <c:if test="${nextBlog != null }">
                    <a href="${nextBlog.blogUrl}" class="next-post text-right d-flex align-items-center justify-content-end">
                      <div class="text">
                        <strong class="text-primary">Next Post </strong>
                        <h6>${nextBlog.title}</h6>
                      </div>
                      <div class="icon next"><i class="fa fa-angle-right"></i></div>
                    </a>
                  </c:if>
                  
                  
                </div>
                 <!-- /.next and previous -->
                
                
                <!-- comments -->
                <div class="post-comments" id="post-comments">
                  <header>
                    <h3 class="h6">Post Comments<span class="no-of-comments">(${blog.comments.size() })</span></h3>
                  </header>
                    <c:forEach var="comment" items="${blog.comments}">
                      <div class="comment">
                      <div class="comment-header d-flex justify-content-between">
                        <div class="user d-flex align-items-center">
                          <div class="image"><img src="img/user.svg" alt="..." class="img-fluid rounded-circle"></div>
                          <div class="title">
                            <strong>${comment.name}</strong>
                            <span class="date"><fmt:formatDate value="${comment.time}" pattern="MMM yyyy"/></span> 
                          </div>
                        </div>
                      </div>
                      <div class="comment-body">
                        <p>${comment.text}</p>
                      </div>
                    </div>
                  </c:forEach>
                </div>
                <!-- /.comment -->
                
                <div class="add-comment">
                  <header>
                    <h3 class="h6">Leave a reply</h3>
                  </header>
                  <form:form action="comment-save" method="post" class="commenting-form" modelAttribute="comment">
                    <form:hidden path="blog.id" value="${blog.id}"/>
                    <form:hidden path="blog.blogUrl" value="${blog.blogUrl}"/>
                  
                    <div class="row">
                      <div class="form-group col-md-6">
                        <form:input path="name" type="text" name="username" id="username" placeholder="Name" class="form-control"/>
                        <form:errors path="name" cssClass="text-danger" cssStyle="font-size: 80%"/>
                      </div>
                      <div class="form-group col-md-6">
                        <form:input path="email" type="text" name="username" id="useremail" placeholder="Email Address (will not be published)" class="form-control"/>
                        <form:errors path="email" cssClass="text-danger" cssStyle="font-size: 80%"/>
                      </div>
                      <div class="form-group col-md-12">
                        <form:textarea path="text" name="usercomment" id="usercomment" placeholder="Type your comment" class="form-control"/>
                        <form:errors path="text" cssClass="text-danger" cssStyle="font-size: 80%"/>
                      </div>
                      <div class="form-group col-md-12">
                        <button type="submit" class="btn btn-secondary">Submit Comment</button>
                      </div>
                    </div>
                  </form:form>
                </div>
              </div>
            </div>
          </div>
        </main>
        <!-- /.blog post -->
        
        <!-- Right side -->
        <aside class="col-lg-4">
          <!-- Widget [Search Bar Widget]-->
          <div class="widget search">
            <header>
              <h3 class="h6">Search the blog</h3>
            </header>
            <form action="${pageContext.request.contextPath}/blog-search" class="search-form">
              <div class="form-group">
                <input type="search" name="search" id="search" placeholder="What are you looking for?">
                <button type="submit" class="submit"><i class="icon-search"></i></button>
              </div>
            </form>
          </div>
          <!-- Widget [Latest Posts Widget]        -->
          <div class="widget latest-posts">
            <header>
              <h3 class="h6">Latest Posts</h3>
            </header>
            <div class="blog-posts">
              <c:forEach var="blog" items="${thereVisitedBlog}">
                <a href="${blog.blogUrl}">
                  <div class="item d-flex align-items-center">
                    <div class="image"><img src="${blog.image}" alt="..." class="img-fluid"></div>
                    <div class="title"><strong>${blog.title}</strong>
                      <div class="d-flex align-items-center">
                        <div class="views"><i class="icon-eye"></i> ${blog.numberOfViews}</div>
                        <div class="comments"><i class="icon-comment"></i>${blog.numberOfComment}</div>
                      </div>
                    </div>
                  </div>
                </a>
              </c:forEach>
            </div>
          </div>
          <!-- Widget [Categories Widget]-->
          <div class="widget categories">
            <header>
              <h3 class="h6">Categories</h3>
            </header>
            <c:forEach var="category" items="${categoryList }">
              <div class="item d-flex justify-content-between">
                <a href="category/${category.categoryUrl}">${category.name }</a>
                <span>${category.numberOfBlogs }</span>
              </div>
            </c:forEach>
          </div>
          <!-- Widget [Tags Cloud Widget]-->
          <div class="widget tags">       
            <header>
              <h3 class="h6">Tags</h3>
            </header>
            <ul class="list-inline">
              <c:forEach var="tag" items="${tagList}">
                <li class="list-inline-item">
                  <a href="tag/${tag.tagUrl}" class="tag">#${tag.name}</a>
                </li>
              </c:forEach>
            </ul>
          </div>
        </aside>
        <!-- /.right side -->
      </div>
    </div>
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
    <script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/popper.js/umd/popper.min.js"> </script>
    <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="${pageContext.request.contextPath}/vendor/@fancyapps/fancybox/jquery.fancybox.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/front.js"></script>
  </body>
</html>