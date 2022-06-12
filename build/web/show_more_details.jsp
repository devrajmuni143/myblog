
<%@page import="com.myblog.dao.LikeDao"%>
<%@page import="com.myblog.dao.UserDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.myblog.entities.Post"%>
<%@page import="com.myblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.myblog.dao.PostDao"%>
<%@page import="com.myblog.helper.ConnectionProvider"%>
<%@page import="com.myblog.entities.Message"%>
<%@page errorPage="error_page.jsp" %>
<%@page import="com.myblog.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    User user = (User) session.getAttribute("CurrentUser");
    if (user == null) {
        response.sendRedirect("Login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 92%, 75% 100%, 44% 95%, 0 100%, 0 0);
            }
            .table tr td{
                text-align: left;

            }
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{

                font-size: 25px;
            }
            .post-date{
                font-size: 20px;
                text-align:right;
                font-style: italic;
            }
            .row-user{
                border: 5px solid #e2e2e2;
                padding-top: 5px;
            }
            body{
                background-image: url(images/bg26.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
    </head>
    <body>
        <!--navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.jsp">My Blog</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="#"><span class="fa fa-home"></span>Home</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <span class="fa fa-check-square-o"></span>Categories
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="#">Programming Languages</a></li>
                                <li><a class="dropdown-item" href="#">Project Implementation</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="#">Data Structure</a></li>
                            </ul>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="#"><span class="fa fa-address-card"></span>Contact</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#postmodal"><span class="fa fa-pencil-square" ></span>Create Post</a>
                        </li>
                    </ul>
                    <ul class="navbar-nav mr-right ">
                        <li class="nav-item">
                            <a class="nav-link" href="#!" data-bs-toggle="modal" data-bs-target="#profilemodal"><span class="fa fa-user-circle" ></span><%= user.getName()%></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="LogoutServlet"><span class="fa fa-user"></span>Logout</a>
                        </li>
                    </ul>

                </div>
            </div>
        </nav>
        <!--end of navbar-->
        <%
            int pId = Integer.parseInt(request.getParameter("pid"));
            UserDao userdao = new UserDao(ConnectionProvider.getConnection());
            PostDao p = new PostDao(ConnectionProvider.getConnection());
            Post post = p.getPostByPostId(pId);
            int uid = post.getUserId();
            User u = userdao.getUserbyUserId(uid);
        %>
        <!--post details-->
        <div class="container ">
            <div class="row mt-5">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header primary-background text-white">
                            <h3 class="post-title"><%= post.getpTitle()%></h3>
                        </div>
                        <div class="card-body">
                            <img src="post_pics/<%= post.getpPic()%>" class="card-img-top" alt="...">
                            <div class="row mt-3 row-user">
                                <div class="col-md-8">
                                    <p class="post-content">Posted by: <a href="ProfilePage.jsp" ><%= u.getName()%></a></p>
                                </div>
                                <div class="col-md-4">
                                    <b class="post-date"><%= DateFormat.getDateTimeInstance().format(post.getpDate())%></b>
                                </div>
                            </div>
                            <p class="post-content"><%= post.getpContent()%></p>
                            <p class="post-content"><%= post.getpCode()%></p>
                        </div>
                        <div class="card-footer btn-outline-primary primary-background">
                            <div class="container">
                                <% LikeDao ld=new LikeDao(ConnectionProvider.getConnection());
                                int postid=ld.countLikesOnPost(post.getpId());
                                
                                
                                %>
                                <a href="#!" class="btn btn-outline-light" onclick="doLike(<%=post.getpId()%>,<%= user.getUid()%>)" style="margin-right: 10px;"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= postid %></span></a>

                                <a href="#!" class="btn btn-outline-light"><i class="fa fa-commenting-o"><span>20</span></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--end of post details-->


        <div class="modal fade" id="postmodal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white">
                        <h5 class="modal-title " id="staticBackdropLabel">Create Post</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="AddPostServlet" method="post" id="post-form" enctype="multipart/form-data">
                            <div class="form-group mb-3">
                                <select class="form-control" name="cid">

                                    <option selected disabled >---Select Category---</option>
                                    <%
                                        PostDao pd = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = pd.getAllCategories();
                                        for (Category c : list) {
                                    %>
                                    <option value="<%=c.getcId()%>"><%=c.getName()%></option>

                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group mb-3">
                                <input type="text" name="ptitle" placeholder="Enter Your Title" class="form-control"/>
                            </div>
                            <div class="form-group mb-3">
                                <textarea name="pcontent" placeholder="Enter Your Content" class="form-control" rows="5"></textarea>
                            </div>
                            <div class="form-group mb-3">
                                <textarea name="pcode" placeholder="Enter Your Program Codes (if any)" class="form-control" rows="5"></textarea>
                            </div>
                            <div class="form-group mb-3">
                                <label for="photo">Select Image</label>
                                <input type="file" name="pic" class="form-control"/>
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-md-lg btn-primary">Post</button>
                            </div>
                        </form>
                        <div class="container mt-3 text-center" style="display: none;" id="loader2">
                            <span class="fa fa-refresh fa-3x fa-spin"></span>
                            <h5>Please Wait..</h5>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>

                    </div>
                </div>
            </div>
        </div>
        <!--End of Post Modal-->

        <!--Profile Modal-->

        <div class="modal fade" id="profilemodal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white">
                        <h5 class="modal-title" id="staticBackdropLabel">MyBlog</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center" >
                            <h3>Profile Details</h3>
                            <img src="user_pics/<%= user.getImage_name()%>" class="image-fluid" style="border-radius: 50%; max-width: 150px; max-height: 250px;" />
                            <h4 class="mt-2"><%= user.getName()%></h4>
                            <div class="container" id="profile-details">

                                <table class="table table-striped table-hover mt-2">
                                    <tr>
                                        <th>User ID : </th>
                                        <td><%= user.getUid()%></td>
                                    </tr>
                                    <tr>
                                        <th>Email : </th>
                                        <td><%= user.getEmail()%></td>
                                    </tr>
                                    <tr>
                                        <th>Password : </th>
                                        <td><%= user.getPassword()%></td>
                                    </tr>
                                    <tr>
                                        <th>Gender : </th>
                                        <td><%= user.getGender()%></td>
                                    </tr>
                                    <tr>
                                        <th>Regd. Date & Time : </th>
                                        <td><%= user.getCreate_time()%></td>
                                    </tr>
                                    <tr>
                                        <th>About : </th>
                                        <td><%= user.getAbout()%></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="container text-center" id="edit-profile" style="display: none;">



                                <form action="UpdateServlet" id="editform" method="post" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                            <th>User ID : </th>
                                            <td><%= user.getUid()%></td>
                                        </tr>
                                        <tr>
                                            <th>Name : </th>
                                            <td><input type="text" name="name" required class="form-control" value="<%= user.getName()%>"></td>
                                        </tr>
                                        <tr>
                                            <th>Email : </th>
                                            <td><input type="email" name="email" required class="form-control" value="<%= user.getEmail()%>"></td>
                                        </tr>
                                        <tr>
                                            <th>Password : </th>
                                            <td><input type="text" name="password" required class="form-control" value="<%= user.getPassword()%>"></td>
                                        </tr>
                                        <tr>
                                            <th>Gender : </th>
                                            <td><%= user.getGender()%></td>
                                        </tr>
                                        <tr>
                                            <th>Regd. Date & Time : </th>
                                            <td><%= user.getCreate_time()%></td>
                                        </tr>
                                        <tr>
                                            <th>About : </th>
                                            <td><textarea class="form-control" name="about" rows="2" value="<%= user.getAbout()%>"></textarea></td>
                                        </tr>
                                        <tr>
                                            <th>Photo : </th>
                                            <td><input type="file" name="photo" required class="form-control" value="<%= user.getImage_name()%>"></td>
                                        </tr>

                                    </table>
                                    <button type="submit" class="btn btn-outline-primary" id="updatebtn">Update</button>
                                    <div class="container mt-3" style="display: none;" id="loader">
                                        <span class="fa fa-refresh fa-3x fa-spin"></span>
                                        <h5>Please Wait..</h5>
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" id="closebtn" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="editbtn">Edit</button>
                    </div>
                </div>
            </div>
        </div>
        <!--End of Profile Modal-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script src="js/myjs.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
                                    $(document).ready(function () {
                                        var togle = false;
                                        $("#editbtn").on("click", function () {
                                            if (togle === false) {
                                                $("#profile-details").hide();
                                                $("#edit-profile").show();
                                                $("#editbtn").text("Back");
                                                togle = true;
                                            } else {
                                                $("#profile-details").show();
                                                $("#edit-profile").hide();
                                                $("#editbtn").text("Edit");
                                                togle = false;
                                            }
                                        });


                                    });

        </script>
        <script>
            $(document).ready(function () {

                $("#editform").on("submit", function (e) {
                    e.preventDefault();
                    let formdata = new FormData(this);
                    $("#loader").show();
                    $.ajax({
                        url: "UpdateServlet",
                        type: "POST",
                        data: formdata,
                        processData: false,
                        contentType: false,
                        success: function (data) {
                            console.log(data);
                            if (data.trim() === "Success") {
                                $("#loader").hide();
                                swal("Success", "User Updated Successfully !");
                                window.location = "ProfilePage.jsp";


                            }
                            ;

                        },
                        error: function () {
                            $("#loader").hide();
                            console.log("error");
                            $("#editform")[0].reset();
                        }
                    });
                });
            });
        </script>
        <script>
            $(document).ready(function () {
                $("#post-form").on("submit", function (e) {
                    e.preventDefault();
                    let formdata2 = new FormData(this);
                    $("#loader2").show();
                    $.ajax({
                        url: "AddPostServlet",
                        type: "POST",
                        data: formdata2,
                        processData: false,
                        contentType: false,
                        success: function (data) {
                            console.log(data);
                            if (data.trim() === "Success") {
                                $("#loader2").hide();
                                swal("Success", "Post Added !");
                                window.location = "ProfilePage.jsp";
                            } else {
                                console.log(data);
                                window.location = "ProfilePage.jsp";
                            }

                        },
                        error: function () {
                            $("#loader2").hide();
                            console.log("error");
                            $("#post-form")[0].reset();
                        }
                    });
                });
            });
        </script>
        <script>
            function getAllPosts(catId, temp) {
                $("#loader3").show();
                $("#post-container").hide();
                $(".c-link").removeClass("active");
                $.ajax({
                    url: "loadPosts.jsp",
                    data: {cid: catId},
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        $(temp).addClass("active");
                        $("#loader3").hide();
                        $("#post-container").show();
                        $("#post-container").html(data);

                    }
                });
            }
            $(document).ready(function () {
                let allPostRef = $(".c-link")[0];
                getAllPosts(0, allPostRef);
            });
        </script>
        <script>
            function doLike(pid, uid) {
                
                let likedata={
                    pid: pid,
                    uid: uid,
                    operation: "like"
                }
                $.ajax({
                   url: "LikeServlet",
                   data: likedata,
                   success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        if(data.trim()==="true"){
                            let c=$(".like-counter").html();
                            c++;
                            $(".like-counter").html(c);
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(data);
                    }
                    
                });
            };

        </script>
    </body>
</html>
