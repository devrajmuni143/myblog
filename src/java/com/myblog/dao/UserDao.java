package com.myblog.dao;

import com.myblog.entities.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.http.HttpSession;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    public boolean addUser(User user) {
        boolean f = false;
        try {
            String qry = "Insert into user (name,email,password,gender,about,photo) values(?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(qry);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());
            pstmt.setString(6, user.getImage_name());

            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public User getUserByEmailAndPassword(String useremail, String password) {
        User user = null;

        try {
            String qry = "Select * from user where email=? and password=?";
            PreparedStatement pstmt = con.prepareStatement(qry);
            pstmt.setString(1, useremail);
            pstmt.setString(2, password);

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUid(rs.getInt("uid"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setCreate_time(rs.getTimestamp("create_time"));
                user.setImage_name(rs.getString("photo"));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;

    }

    public boolean updateUser(User user) {
        boolean status = false;
        try {
            String qry = "update user set name=?, email=?, password=?, about=?, photo=? where uid=?";
            PreparedStatement pstmt = con.prepareStatement(qry);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getAbout());
            pstmt.setString(5, user.getImage_name());
            pstmt.setInt(6, user.getUid());

            pstmt.executeUpdate();
            status = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public User getUserbyUserId(int userId) {
        User user = null;
        try {
            String qry = "select * from user where uid=?";

            PreparedStatement pstmt = con.prepareStatement(qry);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUid(rs.getInt("uid"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setCreate_time(rs.getTimestamp("create_time"));
                user.setImage_name(rs.getString("photo"));
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

}
