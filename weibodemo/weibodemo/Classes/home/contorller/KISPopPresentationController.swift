//
//  KISPopPresentationController.swift
//  weibodemo
//
//  Created by 李威 on 16/8/16.
//  Copyright © 2016年 李威. All rights reserved.
//

import UIKit

class KISPopPresentationController: UIPresentationController {

    let  presenterFrame = CGRectZero
    
    //初始化，用于创建控制器
    /**
     param:presentedViewController 被展现的控制器
     param:presentingViewController 发起的控制器
     */
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController)
    {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    /**
     容器view将要出现的时候调用
     */
     override func containerViewWillLayoutSubviews()
    {
        super.containerViewWillLayoutSubviews()
        
        if presenterFrame == CGRectZero {
            
            presentedView()?.frame = CGRectMake(100, 54, 200, 300)
        }
        else
        {
            presentedView()?.frame = presenterFrame
        }
        // 加载蒙板
        containerView?.insertSubview(coverView, atIndex: 0)
    }
    
    /// 懒加载蒙板
    private lazy var coverView:UIView = {
        
        let view = UIView.init()
        view.frame = UIScreen.mainScreen().bounds
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        let tap = UITapGestureRecognizer.init(target: self, action:#selector(dismiss))
        view.addGestureRecognizer(tap)
        return view
    }()
    /**
     退出控制器
     */
   @objc private func dismiss(){
    
        presentedViewController.dismissViewControllerAnimated(true) {
        
    }}
    
}
