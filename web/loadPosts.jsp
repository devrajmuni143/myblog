<%@page import="com.myblog.entities.User"%>
<%@page import="com.myblog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.myblog.entities.Post"%>
<%@page import="com.myblog.dao.PostDao"%>
<%@page import="com.myblog.helper.ConnectionProvider"%>
<div class="row" style="margin-top: 3px;">
    <%
        PostDao pd = new PostDao(ConnectionProvider.getConnection());
        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> p = null;
        if (cid == 0) {
            p = pd.getAllPosts();
        } else {
            p = pd.getAllPostsByCatId(cid);
        }
        if (p.size() == 0) {
            out.println("<h3 class='display-3 text-white'>No Posts Available in this Category !</h3>");
        }
        for (Post post : p) {
    %>
    <div class="col-md-4 mt-3">
        <div class="card" style="width: 18rem;">
            <img src="post_pics/<%= post.getpPic()%>" class="card-img-top" alt="...">
            <div class="card-body">
                <h5 class="card-title"><%= post.getpTitle()%></h5>
                <p class="card-text"><%= post.getpContent()%></p>

            </div>
            <div class="card-footer primary-background text-center">
                <% LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                    int postid = ld.countLikesOnPost(post.getpId());
                    User user=(User)session.getAttribute("CurrentUser");
                %>
                <a href="#!" onclick="doLike(<%=post.getpId() %>,<%= user.getUid() %>)" class="btn btn-outline-light"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%=postid %></span></a>
                <a href="show_more_details.jsp?pid=<%= post.getpId()%>" class="btn btn-outline-light">Read More</a>
                <a href="#!" class="btn btn-outline-light"><i class="fa fa-commenting-o"><span>20</span></i></a>
            </div>
        </div>
    </div>
    <%
        }
    %>
</div>