//
//  AppDelegate.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/05.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyDOBFtLUsMtqfB1mj3xmaX1Vv-XdwRrFI4")
        KakaoSDKCommon.KakaoSDK.initSDK(appKey: "b81c169c0b6016ab6957c8cebe9a7120")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

