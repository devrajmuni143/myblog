package com.myblog.helper;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionProvider {

    private static Connection conn;

    public static Connection getConnection() {

        if (conn == null) {
            try {
                //Load Driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                //Get Connection
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/myblog", "root", "");

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return conn;
    }
}
