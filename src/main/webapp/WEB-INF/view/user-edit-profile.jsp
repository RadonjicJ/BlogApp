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
   <!-- Toastr -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/toastr/toastr.min.css">
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
          <a class="dropdown-item">
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
          <a class="dropdown-item">
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
            <h1 class="m-0 text-dark">Profile</h1>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
        
        <!-- toast  -->
        <c:if test="${status!=null }">
          <span class="toastrDefaultSuccess" style="display: hide"></span>
        </c:if>
        
        <!-- profile info -->
          <div class="col-md-3">
            <div class="card card-primary card-outline">
              <div class="card-body box-profile">
                <div class="text-center">
                  <img class="profile-user-img img-fluid img-circle" src="${pageContext.request.contextPath}/${loggedUser.image}" alt="User profile picture">
                  
                  <h3 class="profile-username text-center">${loggedUser.name} ${loggedUser.surname}</h3>

                  <ul class="list-group list-group-unbordered mb-3">
                    <li class="list-group-item">
                      <b>${loggedUser.username}</b> 
                    </li>
                    <li class="list-group-item">
                      <b>${loggedUser.email}</b> 
                    </li>
                    <li class="list-group-item">
                      <b>${loggedUser.phone}</b> 
                    </li>
                  </ul>
                  <a href="change-password-form" class="btn btn-primary btn-block"><b>Change password</b></a>
                </div>
                <!-- /.card-body -->
              </div>
            </div>
          </div>
          <!-- /.profile info -->
         
          <div class="col-md-9">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">Edit profile</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
					<form:form class="form-horizontal" role="form" action="user-edit-save" modelAttribute="loggedUser" enctype="multipart/form-data">
                      <form:hidden path="username"/>
                      <form:hidden path="email"/>
                      <form:hidden path="image"/>
                      <form:hidden path="password"/>
                      <form:hidden path="enabled"/>
                      <form:hidden path="authorities"/>
                      
                      <div class="form-group row">
                        <label for="inputName" class="col-sm-2 col-form-label">Name</label>
                        <div class="col-sm-10">
                          <form:input path="name" type="text" class="form-control" id="inputName" placeholder="Name"/>
                          <form:errors path="name" cssClass="text-danger" cssStyle="font-size: 80%"/>
                        </div>
                      </div>
                      <div class="form-group row">
                        <label for="inputSurname" class="col-sm-2 col-form-label">Surname</label>
                        <div class="col-sm-10">
                          <form:input path="surname" type="text" class="form-control" id="inputSurname" placeholder="Surname"/>
                          <form:errors path="surname" cssClass="text-danger" cssStyle="font-size: 80%"/>
                        </div>
                      </div>
                      <div class="form-group row">
                        <label for="inputphone" class="col-sm-2 col-form-label">Phone</label>
                        <div class="col-sm-10">
                          <form:input path="phone" type="text" class="form-control" id="inputName2" placeholder="Phone"/>
                          <form:errors path="phone" cssClass="text-danger" cssStyle="font-size: 80%"/>
                        </div>
                      </div>
                      <div class="form-group row">
                        <label for="exampleInputFile" class="col-sm-2 col-form-label">Image</label>
                        <div class="col-sm-10 input-group">
                          <div class="custom-file">
                            <input type="file" name="file"  id="exampleInputFile" accept="image/png, image/jpeg" />
                            <label class="custom-file-label" for="exampleInputFile">Choose image</label>
                          </div>
                        </div>
                      </div>
                      <div class="form-group row">
                        <div class="offset-sm-2 col-sm-10">
                          <button type="submit" class="btn btn-primary">Save</button>
                        </div>
                      </div>
                    </form:form>
              </div><!-- /.card-body -->
            </div>
            <!-- /.nav-tabs-custom -->
          </div>   
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
<!-- bs-custom-file-input -->
<script src="${pageContext.request.contextPath}/plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>
<!-- Toastr -->
<script src="${pageContext.request.contextPath}/plugins/toastr/toastr.min.js"></script>

<script type="text/javascript">
	$(document).ready(function () {
  		bsCustomFileInput.init();
	});
	
    $('.toastrDefaultSuccess').hide(function() {
        toastr.success('${status}')
      });
</script>

</body>
</html>

