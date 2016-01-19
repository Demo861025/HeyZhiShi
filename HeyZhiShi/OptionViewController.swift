//
//  OptionViewController.swift
//  HeyZhiShi
//
//  Created by 胡海清 on 16/1/1.
//  Copyright © 2016年 胡海清. All rights reserved.
//

import UIKit

class OptionViewController: UIViewController {
    
    var backImageView = UIImageView()
    var rect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "操作"
        
        let size = rect.size
        let width = size.width
        let height = size.height
        backImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        backImageView.image = UIImage(named: "光界面2")
        self.view.addSubview(backImageView)
        self.view.sendSubviewToBack(backImageView)
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func yjqsOnclick(sender: UIButton) {
        
        
        
        
    }
    @IBAction func kfOnclick(sender: UIButton) {
        let conversationVC = KFServiceChatViewController.init(conversationType: RCConversationType.ConversationType_APPSERVICE, targetId: "KEFU145146899064516")
        self.navigationController?.pushViewController(conversationVC, animated: true)
        /*
        //绑定到按钮直接跳转客服页面
        let conversationVC = RCPublicServiceChatViewController.init()
        conversationVC.conversationType=RCConversationType.ConversationType_APPSERVICE
        conversationVC.targetId = "hzs_akf_test"
        conversationVC.title = "黑执事test"
        self.navigationController?.pushViewController(conversationVC, animated: true)
        */
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
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
