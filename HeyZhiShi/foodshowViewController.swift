//
//  foodshowViewController.swift
//  HeyZhiShi
//
//  Created by 胡海清 on 16/1/19.
//  Copyright © 2016年 胡海清. All rights reserved.
//

import UIKit

class foodshowViewController: UIViewController {

    @IBOutlet weak var foodshowwebview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: "https://m.ele.me/shop/468537/38034570?plg_nld=1&plg_nld=1&plg_uin=1&plg_auth=1&plg_usr=1&plg_vkey=1&plg_dev=1")
        
        self.foodshowwebview.loadRequest(NSURLRequest(URL: url!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
