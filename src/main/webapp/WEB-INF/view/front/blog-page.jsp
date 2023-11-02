<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

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
            <!-- Navbar Brand --><a href="${pageContext.request.contextPath}/home" class="navbar-brand">Bootstrap Blog</a>
            <!-- Toggle Button-->
            <button type="button" data-toggle="collapse" data-target="#navbarcollapse" aria-controls="navbarcollapse" aria-expanded="false" aria-label="Toggle navigation" class="navbar-toggler"><span></span><span></span><span></span></button>
          </div>
          <!-- Navbar Menu -->
          <div id="navbarcollapse" class="collapse navbar-collapse">
            <ul class="navbar-nav ml-auto">
              <li class="nav-item"><a href="${pageContext.request.contextPath}/home" class="nav-link">Home</a>
              </li>
              <li class="nav-item"><a href="${pageContext.request.contextPath}/blog" class="nav-link active">Blog</a>
              </li>
              <li class="nav-item"><a href="${pageContext.request.contextPath}/contact" class="nav-link">Contact</a>
              </li>
            </ul>
            <div class="navbar-text"><a href="#" class="search-btn"><i class="icon-search-1"></i></a></div>
          </div>
        </div>
      </nav>
    </header>
    <div class="container">
      <div class="row">
        <!-- Latest Posts -->
        <main class="posts-listing col-lg-8"> 
          <div class="container">
          
          <!-- FOR DIFERENT PAGE    proslijediti username ili ime taga/kategorije-->
          <c:if test="${pageId=='author'}">
            <h2 class="mb-3 author d-flex align-items-center flex-wrap">
              <div class="avatar">
                <img src="${pageContext.request.contextPath}/${author.image}" alt="..." class="img-fluid rounded-circle" style="width: 100px;}">
              </div>
              <div class="title">
                <span>Posts by author "${author.name} ${author.surname}"</span>
              </div>
            </h2>
          </c:if>
          
          <c:if test="${pageId=='category'}">
            <h2 class="mb-3">Category "${category.name}"</h2>
          </c:if>
          
          <c:if test="${pageId=='tag'}">
            <h2 class="mb-3">Tag "${tag.name}"</h2>
          </c:if>
          
          <c:if test="${pageId=='search'}">
            <h2 class="mb-3">Search results for "${searchTerm}"</h2>
          </c:if>
          
            <div class="row">
              <c:forEach var="blog" items="${blogList.pageList}" >
                <!-- post -->
                <div class="post col-xl-6">
                  <div class="post-thumbnail"><a href="${pageContext.request.contextPath}/${blog.blogUrl }"><img src="${pageContext.request.contextPath}/${blog.image}" alt="..." class="img-fluid"></a></div>
                  <div class="post-details">
                    <div class="post-meta d-flex justify-content-between">
                     <div class="date meta-last">
                        <fmt:formatDate pattern = "dd MMMM" value = "${blog.time}" /> | <fmt:formatDate pattern = "yyyy" value = "${blog.time}"/>
                      </div>
                    
                      <div class="category">
                        <c:if test="${blog.category.name != null}">
                          <a href="${pageContext.request.contextPath}/category/${blog.category.categoryUrl}">${blog.category.name }</a>
                        </c:if>
                        <c:if test="${blog.category.name == null}">
                          <a>Uncategorized</a>
                        </c:if>
                      </div>
                    
                    </div>
                    <a href="${pageContext.request.contextPath}/${blog.blogUrl }">
                      <h3 class="h4">${blog.title }</h3>
                    </a>
                    <p class="text-muted">${blog.description}</p>
                    <footer class="post-footer d-flex align-items-center">
                      <a href="${pageContext.request.contextPath}/author/${blog.author.name}-${blog.author.surname}" class="author d-flex align-items-center flex-wrap">
                        <div class="avatar"><img src="${pageContext.request.contextPath}/${blog.author.image }" alt="..." class="img-fluid"></div>
                        <div class="title"><span>${blog.author.name} ${blog.author.surname}</span></div>
                      </a>
                      <div class="date"><i class="icon-clock"></i> ${blog.timeAgo}</div>
                      <div class="comments meta-last"><i class="icon-comment"></i>${blog.numberOfComment}</div>
                    </footer>
                  </div>
                </div>
              
			  </c:forEach>
          </div>
          
          
            <!-- Pagination -->
            <nav aria-label="Page navigation example">
              <ul class="pagination pagination-template d-flex justify-content-center">
              <!-- FOR BLOG 12 PAGE -->
                <c:if test="${pageId=='blog'}">
                  <c:choose>
                    <c:when test="${blogList.firstPage}">
                      <li class="page-item"><a class="page-link"> <i class="fa fa-angle-left"></i></a></li>
                    </c:when>
                    <c:otherwise>
                      <c:url value="prev" var="url"/>
                      <li class="page-item"><a href='<c:out value="${url}"/>' class="page-link"> <i class="fa fa-angle-left"></i></a></li>
                    </c:otherwise>
                  </c:choose> 
                  <c:forEach var="i" begin="1" end="${blogList.getPageCount()}">
                    <li class="page-item"><a href="${pageContext.request.contextPath}/blog/page/${i}" class="page-link active">${i}</a></li>
                  </c:forEach>
                  <c:choose>
                    <c:when test="${blogList.lastPage}">
                      <li class="page-item"><a class="page-link"> <i class="fa fa-angle-right"></i></a></li>
                    </c:when>
                    <c:otherwise>
                      <c:url value="/blog/page/next" var="url"/>
                      <li class="page-item"><a href='<c:out value="${url}"/>' class="page-link"> <i class="fa fa-angle-right"></i></a></li>
                    </c:otherwise>
                  </c:choose> 
                </c:if>
                
                <!-- FOR BLOG BY AUTHOR -->
                <c:if test="${pageId=='author'}">
                  <c:choose>
                    <c:when test="${blogList.firstPage}">
                      <li class="page-item"><a class="page-link"> <i class="fa fa-angle-left"></i></a></li>
                    </c:when>
                    <c:otherwise>
                      <c:url value="prev" var="url"/>
                      <li class="page-item"><a href='<c:out value="${url}"/>' class="page-link"> <i class="fa fa-angle-left"></i></a></li>
                    </c:otherwise>
                  </c:choose> 
                  <c:forEach var="i" begin="1" end="${blogList.getPageCount()}">
                    <li class="page-item"><a href="${pageContext.request.contextPath}/author/${author.name}-${author.surname}/page/${i}" class="page-link active">${i}</a></li>
                  </c:forEach>
                  <c:choose>
                    <c:when test="${blogList.lastPage}">
                      <li class="page-item"><a class="page-link"> <i class="fa fa-angle-right"></i></a></li>
                    </c:when>
                    <c:otherwise>
                      <c:url value="/author/${author.name}-${author.surname}/page/next" var="url"/>
                      <li class="page-item"><a href='<c:out value="${url}"/>' class="page-link"> <i class="fa fa-angle-right"></i></a></li>
                    </c:otherwise>
                  </c:choose> 
                </c:if>
               
                <!-- FOR BLOG BY CATEGORY -->
                <c:if test="${pageId=='category'}">
                  <c:choose>
                    <c:when test="${blogList.firstPage}">
                      <li class="page-item"><a class="page-link"> <i class="fa fa-angle-left"></i></a></li>
                    </c:when>
                    <c:otherwise>
                      <c:url value="prev" var="url"/>
                      <li class="page-item"><a href='<c:out value="${url}"/>' class="page-link"> <i class="fa fa-angle-left"></i></a></li>
                    </c:otherwise>
                  </c:choose> 
                  <c:forEach var="i" begin="1" end="${blogList.getPageCount()}">
                    <li class="page-item"><a href="${pageContext.request.contextPath}/category/${category.categoryUrl}/page/${i}" class="page-link active">${i}</a></li>
                  </c:forEach>
                  <c:choose>
                    <c:when test="${blogList.lastPage}">
                      <li class="page-item"><a class="page-link"> <i class="fa fa-angle-right"></i></a></li>
                    </c:when>
                    <c:otherwise>
                      <c:url value="/category/${category.categoryUrl}/page/next" var="url"/>
                      <li class="page-item"><a href='<c:out value="${url}"/>' class="page-link"> <i class="fa fa-angle-right"></i></a></li>
                    </c:otherwise>
                  </c:choose> 
                </c:if>
                
                
                <!-- FOR BLOG BY TAG -->
                <c:if test="${pageId=='tag'}">
                  <c:choose>
                    <c:when test="${blogList.firstPage}">
                      <li class="page-item"><a class="page-link"> <i class="fa fa-angle-left"></i></a></li>
                    </c:when>
                    <c:otherwise>
                      <c:url value="prev" var="url"/>
                      <li class="page-item"><a href='<c:out value="${url}"/>' class="page-link"> <i class="fa fa-angle-left"></i></a></li>
                    </c:otherwise>
                  </c:choose> 
                  <c:forEach var="i" begin="1" end="${blogList.getPageCount()}">
                    <li class="page-item"><a href="${pageContext.request.contextPath}/tag/${tag.tagUrl}/page/${i}" class="page-link active">${i}</a></li>
                  </c:forEach>
                  <c:choose>
                    <c:when test="${blogList.lastPage}">
                      <li class="page-item"><a class="page-link"> <i class="fa fa-angle-right"></i></a></li>
                    </c:when>
                    <c:otherwise>
                      <c:url value="/tag/${tag.tagUrl}/page/next" var="url"/>
                      <li class="page-item"><a href='<c:out value="${url}"/>' class="page-link"> <i class="fa fa-angle-right"></i></a></li>
                    </c:otherwise>
                  </c:choose> 
                </c:if>
                
                 <!-- FOR BLOG BY SEARCH -->
                <c:if test="${pageId=='search'}">
                  <c:choose>
                    <c:when test="${blogList.firstPage}">
                      <li class="page-item"><a class="page-link"> <i class="fa fa-angle-left"></i></a></li>
                    </c:when>
                    <c:otherwise>
                      <c:url value="prev" var="url"/>
                      <li class="page-item"><a href='<c:out value="${url}"/>' class="page-link"> <i class="fa fa-angle-left"></i></a></li>
                    </c:otherwise>
                  </c:choose> 
                  <c:forEach var="i" begin="1" end="${blogList.getPageCount()}">
                    <li class="page-item"><a href="${pageContext.request.contextPath}/blog-search/page/${i}?search=${searchTerm}" class="page-link active">${i}</a></li>
                  </c:forEach>
                  <c:choose>
                    <c:when test="${blogList.lastPage}">
                      <li class="page-item"><a class="page-link"> <i class="fa fa-angle-right"></i></a></li>
                    </c:when>
                    <c:otherwise>
                      <c:url value="/blog-search/page/next?search=${searchTerm}" var="url"/>
                      <li class="page-item"><a href='<c:out value="${url}"/>' class="page-link"> <i class="fa fa-angle-right"></i></a></li>
                    </c:otherwise>
                  </c:choose> 
                </c:if>
                
              </ul>
            </nav>
          
          </div>
        </main>
        <aside class="col-lg-4">
          <!-- Widget [Search Bar Widget]-->
          <div class="widget search">
            <header>
              <h3 class="h6">Search the blog</h3>
            </header>
            <form action="${pageContext.request.contextPath}/blog-search" class="search-form">
              <div class="form-group">
                <input type="search" name="search" placeholder="What are you looking for?">
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
                <a href="${pageContext.request.contextPath}/${blog.blogUrl }">
                  <div class="item d-flex align-items-center">
                    <div class="image"><img src="${pageContext.request.contextPath}/${blog.image}" alt="..." class="img-fluid"></div>
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
                <a href="${pageContext.request.contextPath}/category/${category.categoryUrl}">${category.name }</a>
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
                  <a href="${pageContext.request.contextPath}/tag/${tag.tagUrl}" class="tag">#${tag.name}</a>
                </li>
              </c:forEach>
            </ul>
          </div>
        </aside>
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
                <li> <a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li> <a href="${pageContext.request.contextPath}/blog">Blog</a></li>
                <li> <a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                <li> <a href="/BlogProject/administration/blog-list">Login</a></li>
              </ul>
              <ul class="list-unstyled">
                <c:forEach var="category" items="${fourImportantCategory}">
                  <li> <a href="${pageContext.request.contextPath}/category/${category.categoryUrl}">${category.name}</a></li>
                </c:forEach>
              </ul>
            </div>
          </div>
          <div class="col-md-4">
            <div class="latest-posts">
            
              <c:forEach var="blog" items="${threeLatestBlog}">
                <a href="${pageContext.request.contextPath}/${blog.blogUrl }" style="display: block;">
                  <div class="post d-flex align-items-center">
                    <div class="image"><img src="${pageContext.request.contextPath}/${blog.image}" alt="..." class="img-fluid"></div>
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