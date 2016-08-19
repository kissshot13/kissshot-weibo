//
//  KIShomeTableViewController.swift
//  weibodemo
//
//  Created by 李威 on 16/8/14.
//  Copyright © 2016年 李威. All rights reserved.
//

import UIKit

class KIShomeTableViewController: KISBaseTableViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //未登入状体
        if !userlogin {
            super.setControllerTpey(KISControllTpye.home)
            return
            
        }
        
        //设置NavgationBar
        setUpNavgationBarItem()
       
    }
    /// 设置设置NavgationBarItem
    private func setUpNavgationBarItem()
    {
        //设置关注好友动态按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.creativeCoustomButton(nil, imageName: "navigationbar_friendattention", target: self, action:#selector(friendattentionButtonClick))
        //设置二维码按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem.creativeCoustomButton(nil, imageName: "navigationbar_pop", target: self, action: #selector(QRCodeButtonClick))
        //设置中间的按
        navigationItem.titleView  = KISTitleButton.kiss_titleButtontitle("kissshot", imageName: "navigationbar_arrow_down", selectedImageName: "navigationbar_arrow_up", target: self, action:#selector(KIShomeTableViewController.popTableView(_:)))
        
    }
    
    ///MARK:-点击事件
    
    @objc func friendattentionButtonClick()
    {
        print(#function)
    }
    //点击二维码按钮
    @objc func QRCodeButtonClick()
    {
        let storyB = UIStoryboard.init(name: "KISQRCodeController", bundle: nil)
        let vc = storyB.instantiateInitialViewController()
        
        presentViewController(vc!, animated: true, completion: nil)
        
    }
    //点击titleview弹出tableview
    @objc func popTableView(btn:KISTitleButton)
    {
        btn.selected = !btn.selected
        //1.加载storyboard
        let sotryB = UIStoryboard.init(name:"KISPopTableViewConroller" , bundle: nil)
        //2.生成控制器
        let popVc = sotryB.instantiateInitialViewController()
        //3.转场代理
        popVc?.transitioningDelegate = self
        //4.设置转场样式
        popVc?.modalPresentationStyle = UIModalPresentationStyle.Custom
        //5.modal出控制器
        presentViewController(popVc!, animated: true, completion: nil)
        
    }
    
    /**
     改变按钮状态
     */
    func titleViewButtonSelected ()
    {
        let titleView = navigationItem.titleView as! KISTitleButton
        
        titleView.selected = !titleView.selected
        
    }

}

/// MARK: - 转场代理
extension KIShomeTableViewController:UIViewControllerTransitioningDelegate{
    //转场控制器
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?
    {
        return KISPopPresentationController.init(presentedViewController: presented, presentingViewController: presenting)
    }
    //弹出转场控制器施行的动画
   func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
   {
        let popAnimation = KISPopAnimation()
      popAnimation.isPresent = true
        return popAnimation

    }
    //关闭转场控制器进行的动画
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        let popAnimation = KISPopAnimation()
        popAnimation.isPresent = false
        titleViewButtonSelected ()
        return popAnimation
    }
    
}

