//
//  Support_iOSApp.swift
//  Support iOS
//
//  Created by Anshad V on 19/03/23.
//

import SwiftUI
import BranchSDK

@main
struct Support_iOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                                    Branch.getInstance().handleDeepLink(url)
                                })
        }
    }
}
