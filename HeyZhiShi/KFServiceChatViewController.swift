//
//  KFServiceChatViewController.swift
//  HeyZhiShi
//
//  Created by 胡海清 on 16/1/3.
//  Copyright © 2016年 胡海清. All rights reserved.
//

import UIKit
import AVFoundation

class KFServiceChatViewController: RCPublicServiceChatViewController {
    
    var session = AVCaptureSession()
    var beginPoint = CGPoint()
    //var rect = UIApplication.sharedApplication().statusBarFrame   //状态栏尺寸
    var rect = UIScreen.mainScreen().bounds
    var tempView1=photoView?()
    var tempView = UIView()
    var item = UIBarButtonItem()
    var gifImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="黑执事"
        //        var gitArray = [UIImage]()
        //        for (var i = 0; i<=40; i++) {
        //            var tempName="0000"+"\(i)"
        //
        //            tempName = "gj_"+tempName.substringFromIndex(tempName.endIndex.advancedBy(-4))+".png"
        //           print(tempName)
        //            gitArray.append(UIImage(named: tempName)!)
        //        }
        //        for (var i = 39; i>=0; i--) {
        //            var tempName="0000"+"\(i)"
        //
        //            tempName = "gj_"+tempName.substringFromIndex(tempName.endIndex.advancedBy(-4))+".png"
        //            print(tempName)
        //            gitArray.append(UIImage(named: tempName)!)
        //        }
        var butlerwelcomegif = UIImage.gifWithNameForImages("PS21214")
        if butlerwelcomegif?.count>0 {
            for (var i = butlerwelcomegif!.count-1; i>=0; i--) {
                
                butlerwelcomegif!.append(butlerwelcomegif![i])
            }
        }
        
        
        
        item=UIBarButtonItem(title: "人物", style: UIBarButtonItemStyle.Plain, target: self, action: "handPhotovcOnshow")
        
        self.navigationItem.rightBarButtonItem=item
        let size = rect.size
        let width = size.width
        let height = size.height
        
        tempView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: height))
        gifImageView = UIImageView.init(frame: CGRect(x: 0, y: 10, width: width, height: height-10))
        //gifImageView.image = UIImage(named: "gj_0000.png")
        gifImageView.image = butlerwelcomegif![0]
        gifImageView.animationImages = butlerwelcomegif //动画图片数组
        gifImageView.animationDuration = 4.5 //执行一次完整动画所需的时长
        gifImageView.animationRepeatCount = 1 //动画重复次数
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
            layer.frame = tempView.layer.bounds
            tempView.layer.insertSublayer(layer, atIndex: 0)
            
            
            tempView.addSubview(gifImageView)
            session.startRunning()
        } catch _ {
            
        }
        //添加手指拖动事件
        let photoPanGesture = UIPanGestureRecognizer(target: self, action: "handlephotoPanGesture:")
        tempView.addGestureRecognizer(photoPanGesture)
        self.view.addSubview(tempView)
        self.view.bringSubviewToFront(self.chatSessionInputBarControl)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.chatSessionInputBarControl.pubSwitchButton.sendActionsForControlEvents(.TouchUpInside)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        gifImageView.startAnimating()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    //将要显示信息回调事件，目的朗读回发消息
    override func willAppendAndDisplayMessage(message: RCMessage!) -> RCMessage! {
        let rectTemp = tempView.frame
        if ((message.messageDirection == .MessageDirection_RECEIVE) && (rectTemp.origin.x == 0) && (rectTemp.origin.y == 0)){
            if let TextMessage = message.content as? RCTextMessage {
                speaking("\(TextMessage.content)")
            }
        }
        return message
    }
    
    //3D人物view移走事件
    func handlephotoPanGesture(sender: UIPanGestureRecognizer){
        //        if  (sender.velocityInView(self.tempView).x > 0) &&  (sender.translationInView(self.tempView).x<0) {
        var rectTemp = tempView.frame
        rectTemp.origin.x = sender.translationInView(self.tempView).x
        tempView.frame = rectTemp
        
        if sender.state == .Ended {
            print("endendedd")
            if (rectTemp.origin.x < -rect.size.width/3){
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    var rectTemp = self.tempView.frame
                    rectTemp.origin.x = -self.rect.size.width
                    self.tempView.frame = rectTemp
                    }, completion: { (Bool) -> Void in
                        self.tempView.hidden = true
                        //                        self.navigationItem.rightBarButtonItem=self.item
                })
            }else{
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    var rectTemp = self.tempView.frame
                    rectTemp.origin.x = 0
                    self.tempView.frame = rectTemp
                    }, completion: { (Bool) -> Void in
                        self.tempView.hidden = false
                })
            }
        }
    }
    
    //self.navigationController右上角人物按钮事件，显示3D人物
    func handPhotovcOnshow(){
        var rectTemp = tempView.frame
        if ((rectTemp.origin.x != 0) || (rectTemp.origin.y != 0)){
            self.tempView.hidden = false
            rectTemp.origin.x = 0
            rectTemp.origin.y = -rectTemp.size.height
            tempView.frame = rectTemp
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                var rectTemp = self.tempView.frame
                rectTemp.origin.x = 0
                rectTemp.origin.y = 0
                self.tempView.frame = rectTemp
                }, completion: { (Bool) -> Void in
                    
            })
        }
    }
    
    //手指碰触事件，目的还原输入栏
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.chatSessionInputBarControl.inputTextView.resignFirstResponder()
    }
    
    //语音朗读
    func speaking(txtmessage :String){
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        }catch let error as NSError{
            print(error.code)
        }
        
        print("sp"+txtmessage)
        let av = AVSpeechSynthesizer.init()
        let utterance1 = AVSpeechUtterance.init(string: txtmessage)
        utterance1.postUtteranceDelay = 0.5
        utterance1.rate = 0.5
        av.speakUtterance(utterance1)
    }
    
    
    /*
    //手指轻划屏幕事件
    func handleSwipeGesture(sender: UISwipeGestureRecognizer){
    //划动的方向
    let direction = sender.direction
    //判断是上下左右
    switch (direction){
    case UISwipeGestureRecognizerDirection.Left:
    print("Left")
    tempView1!.backgroundColor=UIColor.redColor()
    self.chatSessionInputBarControl.setInputBarType(RCChatSessionInputBarControlType.DefaultType, style: RCChatSessionInputBarControlStyle.CHAT_INPUT_BAR_STYLE_SWITCH_CONTAINER)
    self.view.bringSubviewToFront(self.chatSessionInputBarControl)
    break
    case UISwipeGestureRecognizerDirection.Right:
    print("Right")
    break
    case UISwipeGestureRecognizerDirection.Up:
    print("Up")
    break
    case UISwipeGestureRecognizerDirection.Down:
    print("Down")
    break
    default:
    break;
    }
    }
    
    //设置客服输入栏的现实样式，含转人工按钮
    if ((self.conversationType==RCConversationType.ConversationType_APPSERVICE) || (self.conversationType==RCConversationType.ConversationType_PUBLICSERVICE))
    {
    let profile = RCIMClient.sharedRCIMClient().getPublicServiceProfile(RCPublicServiceType(rawValue: 7)!, publicServiceId: self.targetId)
    if ((profile.menu.menuItems) != nil) {
    
    self.chatSessionInputBarControl.setInputBarType(RCChatSessionInputBarControlType.PubType, style: RCChatSessionInputBarControlStyle(rawValue: 0)!)
    self.chatSessionInputBarControl.publicServiceMenu = profile.menu
    }
    }
    */
}
