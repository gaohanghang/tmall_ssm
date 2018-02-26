
package com.how2java.tmall.service;
 
import java.util.List;

import com.how2java.tmall.pojo.User;

public interface UserService {
    void add(User c); 		//增加用户
    void delete(int id);	//删除用户
    void update(User c);	//更新用户
    User get(int id);		//
    List list();			//获取用户列表
    boolean isExist(String name);//判断用户是否存在

    User get(String name, String password); //
}

