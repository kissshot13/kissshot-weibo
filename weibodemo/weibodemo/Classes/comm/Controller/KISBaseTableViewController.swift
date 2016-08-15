//
//  KISBaseTableViewController.swift
//  weibodemo
//
//  Created by 李威 on 16/8/14.
//  Copyright © 2016年 李威. All rights reserved.
//

import UIKit

class KISBaseTableViewController: UITableViewController,KISVisitorViewDelegate {

    //查看用户是否登入
    var userlogin = true
    
    
    var visitorView : KISVisitorView?
    
    
    override func loadView()
    {
        userlogin ? super.loadView() : setUpVisitorView()
    }
    
    
    ///创建游客登入界面
    private func setUpVisitorView() {
            
            visitorView = KISVisitorView()
        
            visitorView?.delegate = self
        
            view = visitorView
    
    }
    
    func setControllerTpey(type:KISControllTpye){
        switch type {
        case KISControllTpye.home:
            setupNavgationItem()
            visitorView?.setupVisitorInfo(KISControllTpye.home)
        case KISControllTpye.message:
            visitorView?.setupVisitorInfo(KISControllTpye.message)
        case KISControllTpye.discovery:
            setupNavgationItem()
            visitorView?.setupVisitorInfo(KISControllTpye.discovery)
        case KISControllTpye.profile:
            visitorView?.setupVisitorInfo(KISControllTpye.profile)
        }
    }
    
    private func setupNavgationItem()  {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "登入", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(loginBtnClick))
    }
    
    
    // MARK:－ 点击事件
    //注册点击
    @objc private func registerBtnClick()
    {
        
        print(#function)
    }
   
    //登入
    @objc private func loginBtnClick()
    {
        
        print(#function)
    }
    
    ///MARK: -KISVisitorViewDelegate
    
    func registerBtnWillClick() {
        
       registerBtnClick()
    }
    
    func loginBtnWillClick() {
        
        loginBtnClick()
    }
    
    
  
}
    
    


