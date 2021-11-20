//
//  CaterifyApp.swift
//  Caterify
//
//  Created by Farrel Anshary on 20/11/21.
//

import SwiftUI
import UIKit
import GoogleMaps

class AppDelegate: NSObject, UIApplicationDelegate    {
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
         let APIKey = "AIzaSyATztB6Rebsdw5-Teg8qRWxeV2BCdUL380"
         GMSServices.provideAPIKey(APIKey)
         return true
     }
 }

@main
struct CaterifyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
