

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 92%, 75% 100%, 44% 95%, 0 100%, 0 0);
            }
        </style>
    </head>
    <body>
        <%@include file="navigation_bar.jsp" %>
        <main class="primary-background banner-background " style="padding-bottom:50px;">
            <div class="container">
                <div class="col-md-4 offset-md-4">
                    <div class="card ">
                        <div class="card-header text-center primary-background text-white ">
                            <span class="fa fa-3x fa-user-plus"></span>
                            <br><!-- comment -->
                            <h4>Register</h4>
                        </div>
                        <div id="alt"  role="alert" Style="text-align: center;">

                        </div>
                        <div class="card-body">
                            <form id="myform" action="RegisterServlet" method="POST" >
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" name="username" class="form-control" id="username" aria-describedby="emailHelp" placeholder="Enter Username">

                                </div>

                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input type="email" name="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">

                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input type="password" name="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                </div>
                                <div class="form-group">
                                    <label for="gender">Gender</label>
                                    <input type="radio" id="gender" name="gender" value="Male">Male
                                    <input type="radio" id="gender"  name="gender" value="Female">Female
                                    <div class="form-group">
                                        <label for="about">About</label>
                                        <textarea name="about" class="form-control" rows="3" id="about" placeholder="Write Something about yourself"></textarea>

                                    </div>
                                    <div class="form-group">
                                        <label for="about">Upload Image</label>
                                        <input type="file" name="image" class="form-control" id="image" ></textarea>

                                    </div>
                                    <br>

                                    <div class="form-check">
                                        <input type="checkbox" name="cond" class="form-check-input" id="exampleCheck1">
                                        <label class="form-check-label" for="exampleCheck1">Check me out</label>

                                    </div>
                                    <div class="container text-center" id="loader" style="display: none;">
                                        <span class="fa fa-refresh fa-spin fa-3x"></span>
                                        <h4>Please Wait..</h4>
                                    </div>

                                    <br>
                                    <button type="submit" class="btn primary-background btn-outline-light">Submit</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>


        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
            $(document).ready(function () {

                console.log("loaded");
                $("#myform").on("submit", function (e) {
                    e.preventDefault();

                    let form_data = new FormData(this);
                    $("#loader").show();
                    $.ajax({
                        url: "RegisterServlet",
                        type: "POST",
                        data: form_data,
                        success: function (data) {
                            if (data.trim() === "Done") {
                                $("#loader").hide();
                                swal("Success", "User Added Successfully !", "success")
                                        .then((value) => {
                                            swal(`Redirecting to Login Page: ${value}`);
                                            window.location = "Login.jsp";
                                        });
                                $("#myform")[0].reset();
//                                

                            } else {
                                $("#loader").hide();
                                swal(data);

                                $("#myform")[0].reset();

                            }
                            ;

                        },
                        error: function () {
                            $("#loader").hide();
                            swal("Error!");
                            $("#myform")[0].reset();

                        },
                        contentType: false,
                        processData: false
                    });
                });
            });
        </script>

    </body>
</html>
