//
//  photoView.swift
//  HeyZhiShi
//
//  Created by 胡海清 on 16/1/6.
//  Copyright © 2016年 胡海清. All rights reserved.
//

import UIKit
import AVFoundation

class photoView: UIView, AVCaptureMetadataOutputObjectsDelegate,
UIAlertViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var scanRectView:UIView!
    var device:AVCaptureDevice!
    var input:AVCaptureDeviceInput!
    var output:AVCaptureMetadataOutput!
    var session:AVCaptureSession!
    var preview:AVCaptureVideoPreviewLayer!
//    
    
}
