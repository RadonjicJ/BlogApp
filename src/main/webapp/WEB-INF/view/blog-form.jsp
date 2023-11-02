<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html style="height: auto;" lang="en">
<head>
  <meta charset="utf-8">
    <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  
  <title>BLOG | CMS</title>

  <!-- Font Awesome -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  <!-- Select2 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/select2/css/select2.min.css">
</head>

<body class="sidebar-mini layout-fixed" style="height: auto;">
  <div class="wrapper">

  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="/BlogProject/" class="nav-link">Web Site</a>
      </li>
    </ul>
    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
      <sec:authorize access="hasRole('admin')">
      <li class="nav-item dropdown">
        <a class="nav-link" href="message-list" aria-expanded="false">
          <i class="far fa-comments"></i>
          <span class="badge badge-danger navbar-badge">${messageCount}</span>
        </a>
      </li>
      </sec:authorize>
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#" aria-expanded="false">
          <i class="far fa-user"></i>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right" style="left: inherit; right: 0px;">
          <a href="user-edit-profile" class="dropdown-item">
            <!-- Message Start -->
            <div class="media align-items-center">
              <img src="${pageContext.request.contextPath}/${loggedUser.image}" alt="User Avatar" class="img-brand-50 mr-3 img-circle" style="width: 100px">
              <div class="media-body">
                <h3 class="dropdown-item-title">
                  ${loggedUser.name} ${loggedUser.surname}
                </h3>
              </div>
            </div>
            <!-- Message End -->
          </a>
          <div class="dropdown-divider"></div>
          <a href="user-edit-profile" class="dropdown-item">
            <i class="fas fa-user"></i> Your Profile
          </a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item">
            <form:form action="${pageContext.request.contextPath}/logout"  class="fas fa-sign-out-alt col-md-12" style="padding-left:0;" >
              <input type="submit" value="Log Out" style="border:none; background-color:white; width:100%; text-align:left; padding-left:0">
            </form:form>
          </a>
        </div>
      </li>
    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="blog-list" class="brand-link">
      <img src="${pageContext.request.contextPath}/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">Blog CMS</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
		  
	        <li class="nav-item has-treeview">
              <a href="#" class="nav-link">
                <i class="nav-icon far fa-plus-square"></i>
                <p>
                  Blogs
                  <i class="fas fa-angle-left right"></i>
                </p>
              </a>
              <ul class="nav nav-treeview">
                <li class="nav-item">
                  <a href="blog-list" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Blog list</p>
                  </a>
                </li>
                <li class="nav-item">
                  <a href="blog-form" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Add Blog</p>
                  </a>
                </li>
              </ul>
            </li>
          <sec:authorize access="hasRole('admin')">
            <li class="nav-item has-treeview">
              <a href="#" class="nav-link">
                <i class="nav-icon far fa-plus-square"></i>
                <p>
                  Slides
                  <i class="fas fa-angle-left right"></i>
                </p>
              </a>
              <ul class="nav nav-treeview">
                <li class="nav-item">
                  <a href="slide-list" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Slide list</p>
                  </a>
                </li>
                <li class="nav-item">
                  <a href="slide-form" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Add Slide</p>
                  </a>
                </li>
              </ul>
            </li>
          </sec:authorize>
          <sec:authorize access="hasRole('admin')">
            <li class="nav-item has-treeview">
              <a href="#" class="nav-link">
                <i class="nav-icon far fa-plus-square"></i>
                <p>
                  Tags
                  <i class="fas fa-angle-left right"></i>
                </p>
              </a>
              <ul class="nav nav-treeview">
                <li class="nav-item">
                  <a href="tag-list" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Tag list</p>
                  </a>
                </li>
                <li class="nav-item">
                  <a href="tag-form" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Add Tag</p>
                  </a>
                </li>
              </ul>
            </li>
          </sec:authorize>
          <sec:authorize access="hasRole('admin')">
            <li class="nav-item has-treeview">
              <a href="#" class="nav-link">
                <i class="nav-icon far fa-plus-square"></i>
                <p>
                  Categories
                  <i class="fas fa-angle-left right"></i>
                </p>
              </a>
              <ul class="nav nav-treeview">
                <li class="nav-item">
                  <a href="category-list" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Category list</p>
                  </a>
                </li>
                <li class="nav-item">
                  <a href="category-form" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Add Category</p>
                  </a>
                </li>
              </ul>
            </li>
          </sec:authorize>
          <sec:authorize access="hasRole('admin')">
            <li class="nav-item has-treeview">
              <a href="#" class="nav-link">
                <i class="nav-icon far fa-plus-square"></i>
                <p>
                  Users
                  <i class="fas fa-angle-left right"></i>
                </p>
              </a>
              <ul class="nav nav-treeview">
                <li class="nav-item">
                  <a href="user-list" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>User list</p>
                  </a>
                </li>
                <li class="nav-item">
                  <a href="user-form" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Add User</p>
                  </a>
                </li>
              </ul>
            </li>
          </sec:authorize>
          <li class="nav-item has-treeview">
            <a href="#" class="nav-link">
              <i class="nav-icon far fa-plus-square"></i>
              <p>
                Others
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <sec:authorize access="hasRole('admin')">
                <li class="nav-item">
                  <a href="message-list" class="nav-link">
                    <i class="far fa-circle nav-icon"></i>
                    <p>Message list</p>
                  </a>
                </li>
              </sec:authorize>
              <li class="nav-item">
                <a href="comment-list" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Comment list</p>
                </a>
              </li>
            </ul>
          </li>
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" style="min-height: 177px;">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0 text-dark">Blog Form</h1>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-12">
           <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">Blog Form</h3>
              </div>
              <!-- /.card-header -->
              
              <!-- form start -->
              <form:form role="form" action="blog-save"  modelAttribute="blog" enctype="multipart/form-data">
                <form:hidden path="id"/>
                <form:hidden path="time"/>
                <form:hidden path="image"/>
                <form:hidden path="secondImage"/>
                <form:hidden path="numberOfViews"/>
                
                <div class="row">
                  <!-- left side -->
                  <div class="col-md-6">
                    <div class="card-body">
                      <div class="form-group">
                        <label>Title</label>
                        <form:input path="title" type="text" class="form-control" placeholder="Enter title"/>
                        <form:errors path="title" cssClass="text-danger" cssStyle="font-size: 80%"/>
	                  </div>
	                  <div class="form-group">
	                    <label>Description</label>
	                    <form:textarea path="description" type="text" class="form-control" placeholder="Enter description" rows="3"/>
	                    <form:errors path="description" cssClass="text-danger" cssStyle="font-size: 80%"/>
	                  </div>
	                  <div class="form-group">
	                    <label>Text</label>
	                    <form:textarea path="text" type="text" class="form-control" placeholder="Enter text" rows="7"/>
	                    <form:errors path="text" cssClass="text-danger" cssStyle="font-size: 80%"/>
	                  </div>
	                  
                    </div>
                    <!-- /.card-body -->
                  </div>
                  <!-- /.left side -->
                  <!-- right side -->
                  <div class="col-md-6">
                    <div class="card-body">
                    
	                  <div class="form-group">
	                    <label>Category</label>
	                    <form:select path="category.id"  class="form-control" data-placeholder="Select Category" style="width: 100%;">
	                    	<form:option selected="true" value="0"  label="---- Choose Category ----"/>
	                    	<form:options  itemValue="id" items="${categoryList}" itemLabel="name"/>
	                    </form:select>
	                  </div>
	                  <form:errors path="category" cssClass="text-danger" cssStyle="font-size: 80%"/>
	                  
	                  <div class="form-group">
	                    <label>Tag</label>
	                    <form:select path="tags" itemValue="id" items="${tagList}" itemLabel="name" class="form-control select2" multiple="multiple" data-placeholder="Select Tags" style="width: 100%;"/>
	                  </div>
	                  <form:errors path="tags" cssClass="text-danger" cssStyle="font-size: 80%"/>
	                  
	                  <!-- images -->
	                  <div class="row">
	                  
	                    <div class=" col-md-6">
	                      <div class="form-group">
                            <label for="exampleInputFile">Main image</label>
                            <div class="input-group">
                              <div class="custom-file">
                                <input type="file" name="file"  id="exampleInputFile" accept="image/png, image/jpeg" />
                                <label class="custom-file-label" for="exampleInputFile">Choose image</label>
                              </div>
                            </div>
                            <p class="text-danger" style="font-size:80%">${errorImage }</p>
                            <c:if test="${blog.image != null}" >
	                      	  <img src="../${blog.image}" style="width: 30%;">
	                        </c:if>
                          </div>
                        </div>
                        <div class=" col-md-6">
						  <div class="form-group">
                            <label for="exampleInputSecondFile">Second image</label>
                            <div class="input-group">
                              <div class="custom-file">
                                <input type="file" name="secondFile"  id="exampleInputSecondFile" accept="image/png, image/jpeg" />
                                <label class="custom-file-label" for="exampleInputSecondFile">Choose image</label>
                              </div>
                            </div>
                            <p class="text-danger" style="font-size:80%"></p>
                            <c:if test="${blog.secondImage != null}" >
	                      	  <img src="../${blog.secondImage}" style="width: 30%;">
	                        </c:if>
                          </div>
	                    </div>
	                    
                      </div>
                      <!-- /.images -->
                      
                      <div class="form-check">
	                    <form:checkbox path="isImportant" class="form-check-input" id="exampleCheck1"/>
	                    <label class="form-check-label" for="exampleCheck1">Is Important</label>
	                  </div>
                    
                    </div>
                    <!-- /.card-body -->
                  </div>
                  <!-- /.right side -->
    			</div>
    			<!-- /.row -->
                <div class="card-footer">
                  <button type="submit" class="btn btn-primary">Save</button>
                  <a href="blog-list" type="button" class="btn btn-outline-secondary">Cancel</a>
                </div>
                
              </form:form>
              <!-- /.form -->
            </div>
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container-fluid -->
    </section> 
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <strong>Copyright © 2023 <a href="#">Jovan Radonjić</a>.</strong>
    All rights reserved.
    <div class="float-right d-none d-sm-inline-block">
      <strong><a href="https://cubes.edu.rs" target="_blank">Cubes School</a></strong> Final Project
    </div>
  </footer>
</div>


<!-- jQuery -->
<script src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="${pageContext.request.contextPath}/plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Bootstrap 4 -->
<script src="${pageContext.request.contextPath}/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/dist/js/adminlte.js"></script>
<!-- Select2 -->
<script src="${pageContext.request.contextPath}/plugins/select2/js/select2.full.min.js"></script>
<!-- bs-custom-file-input -->
<script src="${pageContext.request.contextPath}/plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>
<script>
	$(function(){
		$('.select2').select2()
	})
</script>
<script type="text/javascript">
	$(document).ready(function () {
  		bsCustomFileInput.init();
	});
	
	
</script>
</body>
</html>

