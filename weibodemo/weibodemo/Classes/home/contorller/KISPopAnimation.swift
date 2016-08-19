//
//  KISPopAnimation.swift
//  weibodemo
//
//  Created by 李威 on 16/8/16.
//  Copyright © 2016年 李威. All rights reserved.
//

import UIKit

class KISPopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    var  isPresent :Bool!
    
    
   func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        
        if isPresent == nil {
            return
        }
        
        if isPresent == true
        {
        // 1.拿到展现视图
       let showView = transitionContext.viewForKey(UITransitionContextToViewKey)
        // 2.添加视图到容器view
        transitionContext.containerView()?.addSubview(showView!)
        // 3.修改锚点
        showView?.layer.anchorPoint = CGPointMake(0.5, 0)
        // 4.更改比例
        showView?.transform = CGAffineTransformMakeScale(1, 0)
        // 5.动画
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
            showView?.transform = CGAffineTransformIdentity
            },completion:
            { (_) -> Void in
                // 6.一定要写动画执行完毕
                transitionContext.completeTransition(true)
            })
        }
        else if isPresent == false
        {
        // 1.拿到折叠视图
        let closeView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        // 2.开始动画
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                closeView?.transform = CGAffineTransformMakeScale(1, 0.0000001)
                }, completion: { (_)->Void in
        // 3.一定要写动画执行完毕
                    transitionContext.completeTransition(true)
            })
        }
    }
}