//
//  AppDelegate.swift
//  HeyZhiShi
//
//  Created by 胡海清 on 15/12/22.
//  Copyright © 2015年 胡海清. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        NSThread.sleepForTimeInterval(3.0)//设置启动页面时间
        //初始化融云
        //RCIMClient.sharedRCIMClient().initWithAppKey("cpj2xarljgfkn")
        RCIM.sharedRCIM().initWithAppKey("cpj2xarljgfkn")
        
        //获得leancloud授权
        //[AVOSCloud setApplicationId:@"c0tGa2IhHwP1OHi7qdpYzHdO-gzGzoHsz"
        //clientKey:@"9OlehuDemQR58XTfBkrsacvD"];
        AVOSCloud.setApplicationId("c0tGa2IhHwP1OHi7qdpYzHdO-gzGzoHsz", clientKey: "9OlehuDemQR58XTfBkrsacvD")
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

