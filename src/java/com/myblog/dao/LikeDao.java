
package com.myblog.dao;
import java.sql.*;
public class LikeDao {
    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }
    public boolean saveLike(int pid, int uid)
    {
        boolean f=false;
        String qry="insert into likes (pid,uid) values(?,?)";
        try {
            PreparedStatement pstmt=con.prepareStatement(qry);
            pstmt.setInt(1, pid);
            pstmt.setInt(2, uid);
            pstmt.executeUpdate();
            f=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    public int countLikesOnPost(int pid)
    {
        int count=0;
        String qry="select count(*) from likes where pid=?";
        try {
            PreparedStatement pstmt=con.prepareCall(qry);
            pstmt.setInt(1, pid);
            ResultSet rs=pstmt.executeQuery();
            if(rs.next()){
            count=rs.getInt("count(*)");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    public boolean isLikedByPost(int pid, int uid)
    {
        boolean f=false;
        String qry="select * from likes where pid=? and uid=?";
        try {
            PreparedStatement pstmt=con.prepareStatement(qry);
            pstmt.setInt(1, pid);
            pstmt.setInt(2, uid);
            ResultSet rs=pstmt.executeQuery();
            if(rs.next())
            {
                f=true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
