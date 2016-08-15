//
//  KISprofileTableViewController.swift
//  weibodemo
//
//  Created by 李威 on 16/8/14.
//  Copyright © 2016年 李威. All rights reserved.
//

import UIKit

class KISprofileTableViewController: KISBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !userlogin {
            super.setControllerTpey(KISControllTpye.profile)
        }
        
    }


}
