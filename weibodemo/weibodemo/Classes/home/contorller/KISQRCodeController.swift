//
//  KISQRCodeController.swift
//  weibodemo
//
//  Created by 李威 on 16/8/17.
//  Copyright © 2016年 李威. All rights reserved.
//

import UIKit
import AVFoundation
class KISQRCodeController: UIViewController {
    
    /// 约束框
    @IBOutlet weak var qrcodeImage: UIImageView!
    /// 扫描图案
    @IBOutlet weak var scanView: UIImageView!
    /// 底部tabbar
    @IBOutlet weak var customBar: UITabBar!
    /// 约束框的高度约束
    @IBOutlet weak var QRimageH: NSLayoutConstraint!
    /// 生成二维码按钮
    @IBOutlet weak var myRQCodeButton: UIButton!
    
    // 退出控制器
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   // 打开相册
    @IBAction func openCamera(sender: AnyObject) {
        
    }
    @IBAction func myQRCode(sender: AnyObject) {
        let vc = KISMyQRCodeViewController()
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //默认点击第一个tabtar item
        customBar.selectedItem = customBar.items?.first
        customBar.delegate = self
        reciveNotification ()
        //添加扫码
        begainScan()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //修改我的名片按钮圆角
        myRQCodeButton.layer.cornerRadius = myRQCodeButton.bounds.height/2 - 10
        myRQCodeButton.layer.masksToBounds = true
        //开始动画
        startAnimation()
        //开始扫码
        session.startRunning()
    }
    //状态栏控制
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    // 接受通知
    func reciveNotification ()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(begainLayer), name: KISQRCode, object: nil)
    }
    // 通知调用到方法
    @objc func begainLayer()
    {
        if previewLayer.sublayers?.count > 0{
            //开始动画
            startAnimation()
            //开始扫码
            session.startRunning()
        }
    }
    // 页面退出到时候取消观察者
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    /**
     开始扫描动画
     */
    private func startAnimation() {
        let animation = CABasicAnimation.init(keyPath: "transform.translation.y")
        animation.fromValue = -QRimageH.constant
        animation.toValue = QRimageH.constant
        animation.duration = 3
        animation.repeatCount = MAXFLOAT
        scanView.layer .addAnimation(animation, forKey:"QRAnimation")
        
    }
    /**
     开始扫码
     */
    private func begainScan()
    {
     
        print(input)
        //1.添加进会话
        if !session.canAddInput(input) {
            return print("can'tAddInput")
        }
        if !session.canAddOutput(output) {
            return print("can'tAddOutput")
        }
        session.addInput(input)
        session.addOutput(output)
        //2.设置解析类型
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        //3.添加预览图层
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        previewLayer.addSublayer(conrnerLayer)
        //4.设置代理
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue() )
    }
    
    /// 懒加载session
    private lazy var session:AVCaptureSession = {
       let session = AVCaptureSession()
        return session
    }()
    ///  懒加载输入
    private lazy var input:AVCaptureDeviceInput? = {
       let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do{
           let input = try AVCaptureDeviceInput.init(device: device)
            return input
        }
        catch
        {
            print(error)
            return nil
        }
        
    }()
    /// 懒加载输出
    private lazy var output:AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    /// 懒加载预览图层
    private lazy var previewLayer:AVCaptureVideoPreviewLayer =
    {
        let previewLayer = AVCaptureVideoPreviewLayer.init(session: self.session)
        previewLayer.frame = UIScreen.mainScreen().bounds
        return previewLayer
            
    }()
    /// 懒加载相显示信息的控制器
     private lazy var showMessageVC:KISHShowMessageController = KISHShowMessageController()
    /// 懒加载conrner显示图层
    private lazy var conrnerLayer :CALayer = {
        let conrnerLayer = CALayer()
        conrnerLayer.frame = UIScreen.mainScreen().bounds
        return conrnerLayer
    }()
    
}
// MARK: - UITabBarDelegate
extension KISQRCodeController:UITabBarDelegate{
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem)
    {
        //点击不同item改变高度约束
        if  item == customBar.items![0] {
            QRimageH.constant = 240
        }
        else
        {
            QRimageH.constant = 120
        }
        //移除所有的动画
        scanView.layer .removeAllAnimations()
        //开始动画
        startAnimation()
     
    }
}
// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension KISQRCodeController:AVCaptureMetadataOutputObjectsDelegate{
    //代理方法
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        if metadataObjects != nil
        {
            clearCorners()
            analyMetaDate(metadataObjects)
            popQRCodeMessage(metadataObjects)
        }
        
    }
    
    
    /**
     解析数据码
     - parameter metadataObjects: 输出数据
     */
    private func analyMetaDate(metadataObjects:[AnyObject]!)
    {
        for object in metadataObjects
        {   //如果当前数获取到数据是机器可识别类型
            if object is AVMetadataMachineReadableCodeObject
            {
                //将坐标转换为可识别坐标
                let readableObject = previewLayer.transformedMetadataObjectForMetadataObject(object as! AVMetadataObject) as! AVMetadataMachineReadableCodeObject
                drawCorners(readableObject)
                
            }
        }

    }

    /**
     跳转到二维码信息页
     - parameter metadataObjects: 输出数据
     */
    private func popQRCodeMessage(metadataObjects:[AnyObject]!)
    {
        //获取最后面的字符串
        let str:String? = metadataObjects.last?.stringValue
        if str != nil
        {   //如果字符串以http开头就打开网页
            if str?.hasPrefix("http") == true
            {
                let url = NSURL.init(string: str!)
                UIApplication.sharedApplication().openURL(url!)
            }
            else  // 如果不是就打开文字信息
            {
                showMessageVC.text = str!
                navigationController?.pushViewController(showMessageVC, animated: true)
                //停止扫码
                session.stopRunning()
            }
            
        }
        
        
    }
    
    /**
     绘制边框图层
     - parameter Object: 可以识别到机器codeObject
     */
    private func drawCorners(Object:AVMetadataMachineReadableCodeObject)
    {   //如果corners为空则返回
        if Object.corners.isEmpty {
            return
        }
        //创建shapelayer图层
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeColor = UIColor.redColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        //创建贝塞尔曲线
        let path = UIBezierPath()
        var point = CGPointZero
        var index:Int = 0
        //获取首个点
        CGPointMakeWithDictionaryRepresentation((Object.corners[index] as! CFDictionary), &point)
        path.moveToPoint(point)
        index += 1
        //获取其它点
        while index < Object.corners.count {
        CGPointMakeWithDictionaryRepresentation((Object.corners[index] as! CFDictionary), &point)
        path.addLineToPoint(point)
        index += 1
        }
        //封闭路径
        path.closePath()
        //将路径添加到图层
        layer.path = path.CGPath
        //绘制图层
        conrnerLayer .addSublayer(layer)
        
    }
    // 清除图层
    private func clearCorners()
    {
        
        if conrnerLayer.sublayers?.count > 0
        {
            for layer in conrnerLayer.sublayers!
            {
                layer.removeFromSuperlayer()
            }
        }
    }
    
   
}

