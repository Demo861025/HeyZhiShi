//
//  KFServiceChatViewController.swift
//  HeyZhiShi
//
//  Created by 胡海清 on 16/1/3.
//  Copyright © 2016年 胡海清. All rights reserved.
//

import UIKit

class KFServiceChatViewController: RCPublicServiceChatViewController {

    @IBOutlet weak var photobackview: photoView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.photobackview.hidden=false
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       // self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

    }
}
