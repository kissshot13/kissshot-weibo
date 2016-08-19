//
//  KISTitleButton.swift
//  weibodemo
//
//  Created by 李威 on 16/8/16.
//  Copyright © 2016年 李威. All rights reserved.
//

import UIKit

//写个UIButton子类
class KISTitleButton: UIButton {

    class func kiss_titleButtontitle(title:String?,imageName:String,selectedImageName:String,target:AnyObject?,action:Selector) ->UIButton
    {
    let btn = KISTitleButton.init(type: UIButtonType.Custom)
    btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
    btn.setTitle(title, forState: UIControlState.Normal)
    btn.setImage(UIImage.init(named: imageName), forState: UIControlState.Normal)
    btn.setImage(UIImage.init(named: selectedImageName), forState:UIControlState.Selected)
    btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    btn.sizeToFit()
    return btn
    }
    
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 更改子控件显示
        imageView?.frame.origin.x = (titleLabel?.bounds.width)!+10
        titleLabel?.frame.origin.x = 0
        
    }
    
    //重写高亮状体去除高亮状态
    override var highlighted: Bool
    {
        set{
        }
        get{
            return false
        }
    }
  
    
    
}
