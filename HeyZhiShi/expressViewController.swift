//
//  expressViewController.swift
//  HeyZhiShi
//
//  Created by 胡海清 on 16/1/18.
//  Copyright © 2016年 胡海清. All rights reserved.
//

import UIKit

class expressViewController: UIViewController {

    @IBOutlet weak var expressweb: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: "http://m.ishansong.com/index.html")
        
        expressweb.loadRequest(NSURLRequest(URL: url!))
  
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
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
