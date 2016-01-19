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
    var backImageView = UIImageView()
    var rect = UIScreen.mainScreen().bounds
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登入"
        
        let size = rect.size
        let width = size.width
        let height = size.height
        backImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        backImageView.image = UIImage(named: "光界面2")
        self.view.addSubview(backImageView)
        self.view.sendSubviewToBack(backImageView)
        if let currentUser = AVUser.currentUser() , let token = currentUser["RCToken"] {
            // 允许用户使用应用
            print("\(token)")
            
            RCIM.sharedRCIM().connectWithToken(String(currentUser["RCToken"]),
                success: { (userId) -> Void in
                    dispatch_async(dispatch_get_main_queue()
                        , { () -> Void in
                            //self.successNotice("登陆成功!")
                            self.self.presentNextPage()
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
            
            
            
        } else {
            //缓存用户对象为空时，可打开用户注册界面…
        }
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
    func presentNextPage(){
        
        self.performSegueWithIdentifier("loginAction", sender: self)
    }
    @IBAction func LoginOnClick(sender: UIButton) {
        
        
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
                                self.successNotice("登陆成功!")
                                self.self.presentNextPage()
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

