//
//  PhotoVC.swift
//  HeyZhiShi
//
//  Created by marcus on 16/1/7.
//  Copyright © 2016年 胡海清. All rights reserved.
//

import UIKit
import AVFoundation


class PhotoVC: UIViewController {

    @IBOutlet weak var messagetxt: UITextField!
    @IBOutlet weak var backmessagetxt: UITextField!
    var session = AVCaptureSession()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取摄像头
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        //创建输入流_
        do {
            //创建输入流
            let input = try AVCaptureDeviceInput.init(device: device)
            
             //高质量采集
            session.sessionPreset = AVCaptureSessionPresetHigh
            session.addInput(input)
            let layer = AVCaptureVideoPreviewLayer.init(session: session)
            layer.videoGravity = AVLayerVideoGravityResizeAspectFill
            layer.frame = self.view.layer.bounds
            self.view.layer .insertSublayer(layer, atIndex: 0)
            session.startRunning()
        } catch _ {
            
        }
        
        //上面加入一个View
        let tempView = UIView.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        tempView.backgroundColor = UIColor.redColor()
        self.view.addSubview(tempView)
        
        let RCClient = RCIMClient.sharedRCIMClient()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func sendSMSOnclick(sender: UIButton) {
    }
    @IBAction func changeRGOnclick(sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
