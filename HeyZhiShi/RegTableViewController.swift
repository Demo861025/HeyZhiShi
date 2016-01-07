//
//  RegTableViewController.swift
//  HeyZhiShi
//
//  Created by 胡海清 on 15/12/27.
//  Copyright © 2015年 胡海清. All rights reserved.
//

import UIKit

class RegTableViewController: UITableViewController {

    
    @IBOutlet weak var RegPhoneNum: UITextField!
    @IBOutlet weak var RegNum: UITextField!
    
    @IBOutlet weak var RegSendNum: UIButton!
    @IBOutlet weak var RegDone: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.title = "新用户注册"
    }
    
    @IBAction func RegSendNumOnClicked(sender: AnyObject) {
        self.pleaseWait()
        let user = AVUser()
        let UserQuery = AVQuery(className: "_User")
        UserQuery.whereKey("username", equalTo: self.RegPhoneNum?.text)

        UserQuery.getFirstObjectInBackgroundWithBlock { (userObj, e) -> Void in
            self.clearAllNotice()
            //if e==nil
            //{
                if userObj==nil
                {
                    let net_config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
                    let tokensession = AFHTTPSessionManager.init(sessionConfiguration: net_config)
                    let parameters = [
                        "userId": String(self.RegPhoneNum?.text),
                        "name": "",
                        "portraitUri": ""
                    ]
                    let Timestamp = String(format: "%.0f",NSDate().timeIntervalSince1970)
                    let Nonce: String = String(arc4random())
                    let appSec = "4eqTODlFbdetrp"
                    var sha1 = appSec + Nonce + Timestamp
                    
                    sha1 = (sha1 as NSString).sha1()

                    let url = "https://api.cn.ronghub.com/user/getToken.json"

                    tokensession.requestSerializer.setValue("cpj2xarljgfkn", forHTTPHeaderField: "App-Key")
                    tokensession.requestSerializer.setValue(Nonce, forHTTPHeaderField: "Nonce")
                    
                    tokensession.requestSerializer.setValue(Timestamp, forHTTPHeaderField: "Timestamp")
                    
                    tokensession.requestSerializer.setValue(sha1, forHTTPHeaderField: "Signature")
                    
                    tokensession.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                    tokensession.requestSerializer.setValue("78", forHTTPHeaderField: "Content-Length")
                    
                    let UserInfoTask = tokensession
                        .POST(url, parameters: parameters, progress: { (NSPrognress) -> Void in
                            
                        }, success: { (n, tokendata) -> Void in
                            //let data = tokendata
                            var ttoken = String(tokendata!["token"])
                            let index = ttoken.startIndex.advancedBy(9)
                            let index2 = ttoken.endIndex.advancedBy(-1)
                            let range = Range<String.Index>(start: index,end: index2)
                            
                            ttoken = ttoken.substringWithRange(range)
                            print(tokendata!["token"])
                            print(ttoken)
                            
                            user.username = self.RegPhoneNum?.text
                            user.password =  self.RegPhoneNum?.text
                            //user.email = ""
                            user.sessionToken = ttoken
                            print(user.sessionToken)
                            user.mobilePhoneNumber = self.RegPhoneNum?.text
                            user["RCToken"] = ttoken
                            let error = NSErrorPointer()
                            
                            if user.signUp(error)
                            {
                                self.successNotice("发送成功！")
                            }
                            else
                            {
                                self.errorNotice("发送失败！")
                            }
                        }, failure: { (n, e) -> Void in
                            print(e)
                    })
                    UserInfoTask?.resume()
                }
                else
                {
                    if userObj.objectForKey("mobilePhoneVerified").boolValue==true
                    {
                        self.errorNotice("该手机号已经注册过！")
                    }
                    else
                    {
                        AVUser.requestMobilePhoneVerify(self.RegPhoneNum?.text, withBlock: { (succeeded, e) -> Void in
                            if succeeded
                            {
                                self.successNotice("发送成功！")
                            }
                            else
                            {
                                self.errorNotice("发送失败！")
                            }
                        })
                    }
                }
            //}
            //else
            //{
            //    self.errorNotice("发送失败！")
           // }
        }
        
    }
    
    @IBAction func RegDoneOnClicked(sender: AnyObject) {
        AVUser.verifyMobilePhone(RegNum?.text) { (succeeded, e) -> Void in
            if succeeded {
                self.successNotice("注册成功！")
                self.navigationController?.popViewControllerAnimated(true)
            }
            else
            {
                self.errorNotice("注册失败！")
            }
        }
    }
        
}
