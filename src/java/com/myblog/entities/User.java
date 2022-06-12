
package com.myblog.entities;

import java.sql.Timestamp;


public class User {
    private int uid;
    private String name;
    private String email;
    private String password;
    private String gender;
    private String about;
    private Timestamp create_time;
    private String image_name;
    
    public User(int uid, String name, String email, String password, String gender, String about, Timestamp create_time, String image_name){
        this.uid = uid;
        this.name = name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.about = about;
        this.create_time = create_time;
        this.image_name=image_name;
    }

    public User(String name, String email, String password, String gender, String about, String image_name) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.about = about;
        this.image_name=image_name;
    }   

    public User(String name, String email, String password, String about, String image_name) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.about = about;
        this.image_name = image_name;
    }
    

    public User() {
    }
//    getters and setters

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }

    public Timestamp getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Timestamp create_time) {
        this.create_time = create_time;
    }

    public String getImage_name() {
        return image_name;
    }

    public void setImage_name(String image_name) {
        this.image_name = image_name;
    }

    
}
