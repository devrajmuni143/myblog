
package com.myblog.dao;
import com.myblog.entities.Category;
import com.myblog.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    public ArrayList<Category> getAllCategories()
    {
        ArrayList<Category> list=new ArrayList<>();
        try {
            String qry="Select * from categories";
            PreparedStatement pstmt=con.prepareStatement(qry);
            ResultSet rs=pstmt.executeQuery();
            while(rs.next())
            {   
                Category cat=new Category();
                cat.setcId(rs.getInt("cId"));
                cat.setName(rs.getString("name"));
                cat.setDescription(rs.getString("description"));
                list.add(cat);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean savePost(Post post) {
        boolean flag=false;
        try {
            String pTitle=post.getpTitle();
            String pContent=post.getpContent();
            String pCode=post.getpCode();
            String ppic=post.getpPic();
            int catId=post.getCatId();
            int userId=post.getUserId();
            String qry="Insert into posts (pTitle, pContent, pCode, pPic, catId, userid) values(?,?,?,?,?,?)";
            PreparedStatement pstmt=con.prepareStatement(qry);
            pstmt.setString(1, pTitle);
            pstmt.setString(2, pContent);
            pstmt.setString(3, pCode);
            pstmt.setString(4, ppic);
            pstmt.setInt(5, catId);
            pstmt.setInt(6, userId);
            pstmt.executeUpdate();
            flag=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }
    //get All Posts
    public List<Post> getAllPosts()
    {
        List<Post> list=new ArrayList<>();
        try {
            String qry="Select * from posts";
            PreparedStatement pstmt=con.prepareStatement(qry);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next())
            {
                int pId=rs.getInt("pId");
                String pTitle=rs.getString("pTitle");
                String pContent=rs.getString("pContent");
                String pCode=rs.getString("pCode");
                String pPic=rs.getString("pPic");
                Timestamp pDate=rs.getTimestamp("pDate");
                int catId=rs.getInt("catId");
                int userId=rs.getInt("userId");
                Post post=new Post(pId, pTitle, pContent, pCode, pPic, pDate, catId, userId);
                list.add(post);
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    //get All Posts by CatId
    public List<Post> getAllPostsByCatId(int catId)
    {
        List<Post> list=new ArrayList<>();
        try {
            String qry="Select * from posts where catId=?";
            PreparedStatement pstmt=con.prepareStatement(qry);
            pstmt.setInt(1, catId);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next())
            {
                int pId=rs.getInt("pId");
                String pTitle=rs.getString("pTitle");
                String pContent=rs.getString("pContent");
                String pCode=rs.getString("pCode");
                String pPic=rs.getString("pPic");
                Timestamp pDate=rs.getTimestamp("pDate");
                int userId=rs.getInt("userId");
                Post post=new Post(pId, pTitle, pContent, pCode, pPic, pDate, catId, userId);
                list.add(post);
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public Post getPostByPostId(int postId)
    {
        Post post=null;
        try {
            String qry="Select * from posts where pId=?";
            PreparedStatement pstmt=con.prepareStatement(qry);
            pstmt.setInt(1, postId);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next())
            {
                int pId=rs.getInt("pId");
                String pTitle=rs.getString("pTitle");
                String pContent=rs.getString("pContent");
                String pCode=rs.getString("pCode");
                String pPic=rs.getString("pPic");
                Timestamp pDate=rs.getTimestamp("pDate");
                int catId=rs.getInt("catId");
                int userId=rs.getInt("userId");
                post=new Post(pId, pTitle, pContent, pCode, pPic, pDate, catId, userId);
                return post;
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }
}
