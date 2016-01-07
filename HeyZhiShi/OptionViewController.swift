//
//  OptionViewController.swift
//  HeyZhiShi
//
//  Created by 胡海清 on 16/1/1.
//  Copyright © 2016年 胡海清. All rights reserved.
//

import UIKit

class OptionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func yjqsOnclick(sender: UIButton) {
        let conversationVC = KFServiceChatViewController.init(conversationType: RCConversationType.ConversationType_APPSERVICE, targetId: "KEFU145146899064516")
        self.navigationController?.pushViewController(conversationVC, animated: true)
    }
    @IBAction func kfOnclick(sender: UIButton) {
        let conversationVC = RCPublicServiceChatViewController.init()
        conversationVC.conversationType=RCConversationType.ConversationType_APPSERVICE
        conversationVC.targetId = "hzs_akf_test"

        conversationVC.title = "黑执事test"
//        self.presentViewController(conversationVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(conversationVC, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
