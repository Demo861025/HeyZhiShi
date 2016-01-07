//
//  ViewController.swift
//  HeyZhiShi
//
//  Created by 胡海清 on 15/12/22.
//  Copyright © 2015年 胡海清. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userid: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "主界面"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginOnClick(sender: UIButton) {
        
        func presentNextPage(){
            self.successNotice("登陆成功!")
            self.performSegueWithIdentifier("loginAction", sender: self)
        }
        self.pleaseWait()
        AVUser.logInWithMobilePhoneNumberInBackground(userid.text, password: password.text) { (loginuser, e) -> Void in
            weak var tempSelf = self
            tempSelf!.clearAllNotice()
            if loginuser != nil
            {
                print(loginuser["RCToken"])
                
                RCIM.sharedRCIM().connectWithToken(String(loginuser["RCToken"]),
                    success: { (userId) -> Void in
                        
                        //tempSelf!.performSegueWithIdentifier("loginAction", sender: tempSelf!)
                        dispatch_async(dispatch_get_main_queue()
                            , { () -> Void in
                                presentNextPage()
                        })
                        
                        print("登陆成功。当前登录的用户ID：\(userId)")
                    }, error: { (status) -> Void in
                        self.errorNotice("登陆失败！")
                        print("登陆的错误码为:\(status.rawValue)")
                    }, tokenIncorrect: {
                        self.errorNotice("登陆失败！")
                        //token过期或者不正确。
                        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                        //                        print("token错误")
                })
            }
            else
            {
                self.errorNotice("登陆失败！")
            }
        }
        
    }
    
}

