//
//  KISMyQRCodeViewController.swift
//  weibodemo
//
//  Created by 李威 on 16/8/17.
//  Copyright © 2016年 李威. All rights reserved.
//

import UIKit
import KGNAutoLayout

class KISMyQRCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "我的名片"
        view.backgroundColor = UIColor.init(white:0.85, alpha: 1)
        view.addSubview(myQRCodeImage)
        myQRCodeImage.centerInSuperview()
        myQRCodeImage.sizeToWidthAndHeight(240)
        myQRCodeImage.image = creatMyQRCode()
        
    }
    /**
     创建二维码
     */
    private func creatMyQRCode() ->UIImage
    {
    
        //1.创建滤镜
        let filter = CIFilter.init(name: "CIQRCodeGenerator")
        //2.还原滤镜的默认属性
        filter?.setDefaults()
        //3.设置需要生成的二维码的数据
        filter?.setValue("kissshot".dataUsingEncoding(NSUTF8StringEncoding), forKey: "inputMessage")
        //4.从滤镜中取出图片
        let ciImage = filter?.outputImage
        
        var image = makeUIImagefromCIImage(ciImage!, size:CGSizeMake(300,300))
        image = addIcon(image, icon: UIImage.init(named: "other")!)
        
        return image
        
    }
    /**
     使模糊图像高清
     - parameter image: 二维码图
     - parameter size:  生成的图片大小
     - returns: 返回清晰的二位码图
     */
    private func makeUIImagefromCIImage(image:CIImage,size:CGSize) -> UIImage
    {
        let extent:CGRect = CGRectIntegral(image.extent)
        let scale = min(size.width/extent.width, size.height/extent.height)
        //创建位图上下文
        let width = CGRectGetWidth(extent)*scale
        let height = CGRectGetHeight(extent)*scale
        let cs:CGColorSpaceRef = CGColorSpaceCreateDeviceGray()!
        let bitmapcontext = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, cs, 0)
        CGContextSetInterpolationQuality(bitmapcontext, CGInterpolationQuality.None)
        CGContextScaleCTM(bitmapcontext, scale, scale)
        
        //创建ci上下文
        let context = CIContext.init(options: nil)
        let bitmapImage :CGImageRef = context.createCGImage(image, fromRect: extent)
        CGContextDrawImage(bitmapcontext, extent, bitmapImage)
        
        let scaleImage :CGImageRef = CGBitmapContextCreateImage(bitmapcontext)!
        
        return UIImage(CGImage: scaleImage)
        
    }
    //加入头像合成二维码
    private func addIcon(bigImage:UIImage,icon:UIImage) ->UIImage
    {
        //开启绘图上下文
        UIGraphicsBeginImageContext(bigImage.size)
        //大图片绘图
        bigImage.drawInRect(CGRect.init(origin:CGPointZero, size: bigImage.size))
        //头像绘图
        let width :CGFloat = 100
        let height = width
        let x = (bigImage.size.width - icon.size.width)/2
        let y = (bigImage.size.height - icon.size.height)/2
        icon.drawInRect(CGRectMake(x, y, width, height))
        //获取图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        //返回合成图片
        return newImage
    }
    
    /// 懒加载图片
    private lazy var myQRCodeImage:UIImageView = UIImageView.init()

}
