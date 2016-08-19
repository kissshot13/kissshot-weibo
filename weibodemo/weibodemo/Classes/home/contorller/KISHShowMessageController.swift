//
//  KISHShowMessageController.swift
//  weibodemo
//
//  Created by 李威 on 16/8/18.
//  Copyright © 2016年 李威. All rights reserved.
//

import UIKit

class KISHShowMessageController: UIViewController {

    @IBOutlet weak var lable: UILabel!
    
    var text:String = "NoMessage"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lable.text = text
        
    }


}
