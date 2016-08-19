//
//  UIBarButtonItem+CustomButton.swift
//  weibodemo
//
//  Created by 李威 on 16/8/16.
//  Copyright © 2016年 李威. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    ///创建快速创按钮view的方法
    class func creativeCoustomButton(title:String?,imageName:String,target:AnyObject?,action:Selector) -> UIBarButtonItem
    {
        let btn = UIButton.init()
        btn.setTitle(title, forState: UIControlState.Normal)
        btn.setImage(UIImage.init(named:imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage.init(named:imageName+"_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        return UIBarButtonItem.init(customView: btn)
    }
    
}