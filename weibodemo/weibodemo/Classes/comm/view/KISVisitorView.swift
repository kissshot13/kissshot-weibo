//
//  KISVisitorView.swift
//  weibodemo
//
//  Created by 李威 on 16/8/14.
//  Copyright © 2016年 李威. All rights reserved.
//

import UIKit
import KGNAutoLayout

 //设置点击的代理
protocol KISVisitorViewDelegate:NSObjectProtocol
    {
        
        //注册
        func registerBtnWillClick()
        //登入
        func loginBtnWillClick()
    }
    
class KISVisitorView: UIView {

    //定义一个delegate
    weak var delegate : KISVisitorViewDelegate?
    
   // 1 MARK:-初始化
    // 1.1初始化界面
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        addSubview()
        
    }
    // 1.2初始化界面
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 1.3 添加子控件
    private func addSubview() {
        
        backgroundColor = UIColor.whiteColor()
        
        // 加载子控件
        addSubview(backGroundView)
        addSubview(maskBGImageV)
        addSubview(houseImageView)
        addSubview(textLable)
        addSubview(findButton)
        addSubview(registerButton)
        addSubview(loginButton)
        addSubview(profieImageV)
        profieImageV.addSubview(icon)
        
        //设置按钮颜色
        UIButton.appearance().tintColor = KISBGColor
        
        //开始动画
        startAnimation()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 布局子控件
        houseImageView.centerVerticallyInSuperview(offset: -40)
        houseImageView.centerHorizontallyInSuperview()
        
        backGroundView.centerVerticallyInSuperview(offset: -40)
        backGroundView.centerHorizontallyInSuperview()
        
        maskBGImageV.positionBelowItem(backGroundView,offset: -50)
        maskBGImageV.sizeToWidth(UIScreen.mainScreen().bounds.width)
        maskBGImageV.sizeToHeight(40)
        
        textLable.positionBelowItem(backGroundView)
        textLable.pinToSideEdgesOfSuperview(offset: 30)
        textLable.sizeToHeight(60)
        
        loginButton.positionBelowItem(textLable,offset: 10)
        loginButton.pinLeftEdgeToLeftEdgeOfItem(textLable)
        loginButton.sizeToWidth(120)
        loginButton.sizeToHeight(40)
        
        registerButton.positionBelowItem(textLable,offset: 10)
        registerButton.pinRightEdgeToRightEdgeOfItem(textLable)
        registerButton.sizeToWidth(120)
        registerButton.sizeToHeight(40)
        
        findButton.positionBelowItem(textLable,offset:10)
        findButton.centerHorizontallyInSuperview()
        findButton.sizeToWidth(120)
        findButton.sizeToHeight(40)
        
        profieImageV.pinToTopEdgeOfSuperview(offset: 64)
        profieImageV.pinToSideEdgesOfSuperview()
        profieImageV.sizeToHeight(self.bounds.height/3)
        
        icon.centerInSuperview()
        icon.sizeToWidthAndHeight(80)
        icon.layer.cornerRadius = 40
        icon.layer.masksToBounds = true
        icon.layer.borderColor = UIColor.grayColor().CGColor
        icon.layer.borderWidth = 2;
    }
    
    // 添加动画
    private func startAnimation()
    {
        let animation = CABasicAnimation.init()
        
        animation.keyPath = "transform.rotation"
        
        animation.toValue = M_PI*2
        
        animation.repeatCount = MAXFLOAT
        
        animation.duration = 20
        
        animation.removedOnCompletion = false
        
        animation.fillMode = "forwards"
        
        backGroundView.layer.addAnimation(animation, forKey: nil)
        
    }
    
    // 2 MARK:-点击事件
    
   @objc private func registerBtnWillClick() {
    
        delegate?.registerBtnWillClick()
    }
    
    @objc private func loginBtnWillClick() {
        
        delegate?.loginBtnWillClick()
    }
    @objc private func findButtonWillClick()
    {
        print(#function)
    }
    @objc private func iconButtonClick()
    {
        print(#function)
    }
    
    // 3 MARK:-懒加载
    
    ///3.1.加载背景
    private lazy var backGroundView:UIImageView = {
       
        let imageV = UIImageView.init(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        
        return imageV
    }()
    
    ///3.2.加载房子图片
    private lazy var houseImageView:UIImageView = {
        
        let imageV = UIImageView.init(image: UIImage(named: "visitordiscover_feed_image_house"))
        
        return imageV
    }()
    ///3.3.加载登入按钮
    private lazy var  loginButton: UIButton = {
       
        let btn = UIButton.init(type: UIButtonType.System)
        
        btn.setTitle("登录", forState: UIControlState.Normal)
        
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        
        btn.addTarget(self, action: #selector(loginBtnWillClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    ///3.4 加载注册按钮
    private lazy var  registerButton: UIButton = {
        
        let btn = UIButton.init(type: UIButtonType.System)
        
        btn.setTitle("注册", forState: UIControlState.Normal)
        
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        
        btn.addTarget(self, action: #selector(registerBtnWillClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    ///3.5关注按钮
    private lazy var findButton:UIButton = {
        let btn = UIButton.init(type: UIButtonType.System)
        
        btn.setTitle("关注", forState: UIControlState.Normal)
        
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        
        btn.addTarget(self, action: #selector(findButtonWillClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn

    }()
    /// 3.6 介绍说明
    private lazy var textLable :UILabel = {
       
        let lable = UILabel.init()
        
        lable.numberOfLines = 0
        
        lable.textAlignment = NSTextAlignment.Center
        
        lable.textColor = UIColor.darkGrayColor()
        
        lable.text = "关注一些人,看看有什么惊喜"
        
        return lable
    }()
    /// 3.7 背景下半部分遮挡
    private lazy var maskBGImageV: UIView = {
      
        let whiteView = UIView.init()
        
        whiteView.backgroundColor = UIColor.whiteColor()
        
        return whiteView
    }()
    /// 3.8 提供profie部分上北京图片
    private lazy var profieImageV:UIImageView = {
       
        let  imageV = UIImageView.init()
        
        return imageV
    }()
    /// 3.9 头像
    private lazy var icon:UIButton = {
        
        let btn = UIButton.init(type: UIButtonType.System)
        
        btn.setBackgroundImage(UIImage(named: "avatar_default_big"), forState: UIControlState.Normal)
        
        btn.addTarget(self, action: #selector(iconButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    
    /// MARK:- 提供接口供外部安type修改
    func setupVisitorInfo(type:KISControllTpye) {
        
        if type == KISControllTpye.home {
            
            registerButton.hidden = true
            loginButton.hidden = true
            profieImageV.hidden = true
        }
        else if type == KISControllTpye.message {
            
            backGroundView.hidden = true
            findButton.hidden = true
            maskBGImageV.hidden = true
            profieImageV.hidden = true
            houseImageView.image = UIImage.init(named:"visitordiscover_image_message")
            textLable.text =
            "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知"
        }
        else if type == KISControllTpye.discovery
        {
            for view:UIView in subviews {
                view.hidden = true
            }
        }
        else
        {
            backGroundView.hidden = true
            houseImageView.hidden = true
            maskBGImageV.hidden = true
            textLable.text =
            "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知"
            findButton.hidden = true
            profieImageV.image = UIImage.init(named:"20150531223314_Tfeti")
            profieImageV.userInteractionEnabled = true
            backgroundColor = UIColor.init(colorLiteralRed: 233.0/255.0, green: 233.0/255.0, blue: 233.0/255.0, alpha: 1)
            
        }
        
    }

}
