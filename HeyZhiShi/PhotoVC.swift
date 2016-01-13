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

//    func onReceived(message: RCMessage!, left nLeft: Int32, object: AnyObject!) {
//        //let messagedata = NSData()
//        backmessagetxt.text=message.objectName
//       // message.content.decodeWithData(messagedata)
//       // backmessagetxt.text=messagedata.
//    }
    
    @IBOutlet weak var messagetxt: UITextField!
    @IBOutlet weak var backmessagetxt: UITextField!
    var session = AVCaptureSession()
    let tempView = UIView.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
    @IBOutlet weak var ptvc: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //var delegate : photovcReceiveMessageDelegate?
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
            layer.frame = self.ptvc.layer.bounds
            self.ptvc.layer.insertSublayer(layer, atIndex: 0)
            session.startRunning()
        } catch _ {
            
        }
        
        //上面加入一个View
        //let tempView = UIView.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        //tempView.backgroundColor = UIColor.redColor()
        //self.ptvc.backgroundColor = UIColor.redColor()

        self.view.addSubview(tempView)
        
        //let RCIMClientRMessageDelegate=RCIMClientReceiveMessageDelegate.self
        //let RCClient = RCIMClient.sharedRCIMClient()
//RCIMClient.sharedRCIMClient().setReceiveMessageDelegate(delegate?, object: "photovc")
       // RCClient.setReceiveMessageDelegate( object: "photovc")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendSMSOnclick(sender: UIButton) {
        let sendmessage = RCTextMessage.init(content: messagetxt.text)
        
        RCIMClient.sharedRCIMClient()
            .sendMessage(RCConversationType.ConversationType_APPSERVICE, targetId: "KEFU145146899064516", content: sendmessage, pushContent: messagetxt.text, success: { (backid) -> Void in
            print("backid")
            }) { (e, backid) -> Void in
                print(e)
        }
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

