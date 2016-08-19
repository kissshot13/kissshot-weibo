//
//  AppDelegate.swift
//  weibodemo
//
//  Created by 李威 on 16/8/13.
//  Copyright © 2016年 李威. All rights reserved.
//

/*
 App Key：3003594126
 App Secret：cb0fdb879d7d5cb3b35e8b8ae7af193a
 */

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow()
        
        window?.frame = UIScreen.mainScreen().bounds;
        
        let mainVc = KISMainViewController()
        
        window?.rootViewController = mainVc
        
        window?.makeKeyAndVisible()
        
        // 设置所有的UItabBar颜色为橘黄色
        UITabBar.appearance().tintColor = KISBGColor
        
        // 设置所有的NavigationBar颜色为橘黄色
        UINavigationBar.appearance().tintColor = KISBGColor
        
        return true
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        
        NSNotificationCenter.defaultCenter().postNotificationName(KISQRCode, object: nil)
    }


   
}

