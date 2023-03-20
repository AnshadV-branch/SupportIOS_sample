//
//  AppDelegate.swift
//  Support iOS
//
//  Created by Anshad V on 19/03/23.
//

import Foundation
import UIKit
import BranchSDK

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // if you are using the TEST key
        //Branch.setUseTestBranchKey(true)
        Branch.getInstance().enableLogging()
        
        //Branch.getInstance().validateSDKIntegration()
        // listener for Branch Deep Link data
        Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
            // do stuff with deep link data (nav to page, display content, etc)
            print(params as? [String: AnyObject] ?? {})
            
            guard let data = params as? [String: AnyObject] else { return }
            
            let alert = UIAlertController(title: "Deep link data", message: "\(data)", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)

            
        }
        
        
        return true
    
    }
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        Branch.getInstance().application(app, open: url, options: options)
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        // handler for Universal Links
        Branch.getInstance().continue(userActivity)
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // handler for Push Notifications
        Branch.getInstance().handlePushNotification(userInfo)
    }
}
