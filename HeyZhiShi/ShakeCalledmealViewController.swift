//
//  ShakeCalledmealViewController.swift
//  HeyZhiShi
//
//  Created by 胡海清 on 16/1/13.
//  Copyright © 2016年 胡海清. All rights reserved.
//

import UIKit



class ShakeCalledmealViewController: UIViewController,DKDropMenuDelegate{

    @IBOutlet weak var styleofcooking: DKDropMenu!
    @IBOutlet weak var taste: DKDropMenu!
    @IBOutlet weak var rangeofprice: DKDropMenu!
    
    var rect = UIScreen.mainScreen().bounds
    var backImageView = UIImageView()
    var backupImageView = UIImageView()
    var backdownImageView = UIImageView()
    
    func itemSelectedWithIndex(index: Int, name: String) {
        print(name+" selected")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置允许摇一摇功能
        UIApplication.sharedApplication().applicationSupportsShakeToEdit = true
        // 并让自己成为第一响应者
        self.becomeFirstResponder()
        
        let size = rect.size
        let width = size.width
        let height = size.height
        
        backImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        backImageView.image = UIImage(named: "Shake_back")
        self.view.addSubview(backImageView)
        
        backupImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: width, height: height/2))
        backupImageView.image = UIImage(named: "Shake_Up")
        self.view.addSubview(backupImageView)
        
        backdownImageView = UIImageView.init(frame: CGRect(x: 0, y: height/2, width: width, height: height/2))
        backdownImageView.image = UIImage(named: "Shake_Down")
        self.view.addSubview(backdownImageView)
        
        
        styleofcooking.addItems(["川菜", "鲁菜", "粤菜","苏菜"])
        styleofcooking.delegate = self
        taste.addItems(["香辣", "酸甜", "清淡"])
        taste.delegate = self
        rangeofprice.addItems(["10元以下", "10~20元", "20~30元"])
        rangeofprice.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        let animateDuration: NSTimeInterval = 0.3
        let offsetY: CGFloat = 50
        
        UIView.animateWithDuration(animateDuration, animations: { () -> Void in
            self.backupImageView.transform = CGAffineTransformMakeTranslation(0, -offsetY)
            self.backdownImageView.transform = CGAffineTransformMakeTranslation(0, offsetY)
            
            }) { (finish) -> Void in
//                          //  AudioServicesPlayAlertSound(self.soundID!)

                }
        print("begin")
    }
    
    override func motionCancelled(motion: UIEventSubtype, withEvent event: UIEvent?) {
        //super.motionCancelled(motion, withEvent: event)
        print("cancel")
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        let animateDuration: NSTimeInterval = 0.3
       // let offsetY: CGFloat = 50
        UIView.animateWithDuration(animateDuration, animations: { () -> Void in
            self.backupImageView.transform = CGAffineTransformIdentity
            self.backdownImageView.transform = CGAffineTransformIdentity
            
            }) { (finish) -> Void in

            }
        print(styleofcooking.selectedItem)
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
