//
//  KISMainViewController.swift
//  weibodemo
//
//  Created by 李威 on 16/8/14.
//  Copyright © 2016年 李威. All rights reserved.
//

import UIKit

class KISMainViewController: UITabBarController {

    override func viewDidLoad()
    {
        super.viewDidLoad()

        setUpChildController("KIShomeTableViewController", title: "首页", image: "tabbar_home")
        setUpChildController("KISmessageTableViewController", title: "消息", image: "tabbar_message_center")
        
        setUpChildController("KISPushViewController", title: "", image: "")
        
        setUpChildController("KISdiscoveryTableViewController", title: "发现", image: "tabbar_discover")
        setUpChildController("KISprofileTableViewController", title: "我", image: "tabbar_profile")
    }
    
    // 屏幕将出现的时候加载按钮
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addPushButton()
        
    }
    
    
    ///  创建子控制器
    private func setUpChildController(childControllerName:String ,title:String ,image:String )
    {
        //动态获取命名空间
        let name = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        //拼接
        let cls:AnyClass? = NSClassFromString(name+"."+childControllerName)
        
        //类型转化
        let clsN = cls as! UIViewController.Type
        // 初始化
        let vc = clsN.init()
       
        //设置tabbar的图片和文字
        vc.tabBarItem = UITabBarItem.init(title: title, image: UIImage(named: image), selectedImage: UIImage(named: image+"_highlighted"))
        // 创建navc
        let nav = UINavigationController.init(rootViewController: vc)
        
        addChildViewController(nav)
    
    }
    
    private func
        addPushButton()
    {
        tabBar.addSubview(PushButton)
        
        let width = UIScreen.mainScreen().bounds.width/CGFloat(childViewControllers.count)
        
        let x = width * 2.0
        
        let heiht = tabBar.bounds.height
        
        PushButton.frame = CGRectMake(x, 0, width, heiht)
        
    }
    
    ///懒加载按钮
    private lazy var PushButton:UIButton = {
        let btn = UIButton.init(type:UIButtonType.System)
        // 设置图片
        btn.setImage(UIImage(named:"tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        btn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"), forState:UIControlState.Normal)
        
        btn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button_highlighted"), forState:UIControlState.Highlighted)
        
        btn.addTarget(self, action: #selector(PushButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
    
        return btn
    }()
    
    func PushButtonClick() {
        
        presentedViewController?.childViewControllers[2]
    }

}
