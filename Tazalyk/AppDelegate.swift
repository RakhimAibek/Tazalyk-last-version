//
//  AppDelegate.swift
//  Tazalyk
//
//  Created by Aibek Rakhim on 7/21/17.
//  Copyright © 2017 Next Step. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import StoreKit
import Siren
import Firebase
import UserNotifications
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UINavigationControllerDelegate {

    var window: UIWindow?
    var firstNavigationController: UINavigationController?
    var firstViewController: UIViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.firstNavigationController = UINavigationController()
        
        //hide or not hide onboarding pages
        if UserDefaults.standard.object(forKey: "onboardingDefaults") != nil {
            firstViewController = FirstViewController()
        } else if UserDefaults.standard.object(forKey: "onboardingDefaults") == nil {
            firstViewController = OnboardingVC()
        }

        if let firstNavigationController = self.firstNavigationController {
            
            firstNavigationController.delegate = self
            firstNavigationController.setNavigationBarHidden(true, animated: false)
            firstNavigationController.pushViewController(firstViewController!, animated: false)
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            if let window = self.window {
                window.rootViewController = firstNavigationController
                window.makeKeyAndVisible()
                setupSiren()
            }
            
        }
        
        //UserNotification
        if #available(iOS 10, *) {
            let authOptions: UNAuthorizationOptions = [.badge, .sound, .alert]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { (granted, error) in
                    application.registerForRemoteNotifications()
            })
        } else {
                let notificationSettings = UIUserNotificationSettings(types: [.badge, .alert, .sound], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(notificationSettings)
                UIApplication.shared.registerForRemoteNotifications()
        }
    
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        Fabric.with([Crashlytics.self])
        // TODO: Move this to where you establish a user session
        return true
    }
    
     func setupSiren() {
        
        let siren = Siren.shared
        siren.debugEnabled = true
        
        siren.majorUpdateAlertType = .option
        siren.minorUpdateAlertType = .option
        siren.patchUpdateAlertType = .option
        siren.revisionUpdateAlertType = .option
        siren.forceLanguageLocalization = Siren.LanguageType.Russian
        
    }

    //Added from other example of project
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Auth.auth().setAPNSToken(deviceToken, type: AuthAPNSTokenType.prod)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification notification: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if Auth.auth().canHandleNotification(notification) {
            completionHandler(UIBackgroundFetchResult.noData)
            return
        }
        // This notification is not auth related, developer should handle it.
    }
    
    func requestReview() {
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.show(withStatus: "Секунду..")
        
        if #available(iOS 10.3, *) {
            SVProgressHUD.dismiss(withDelay: 1.5)
            SKStoreReviewController.requestReview()
        } else {
            // Fallback on earlier versions
            SVProgressHUD.dismiss()
            print("Rate is disable")
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        Siren.shared.checkVersion(checkType: .immediately)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        Siren.shared.checkVersion(checkType: .immediately)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate: SirenDelegate {
    
    func sirenDidShowUpdateDialog(alertType: Siren.AlertType) {
        print(#function, alertType)
    }
    
    func sirenUserDidCancel() {
        print(#function)
    }
    
    func sirenUserDidSkipVersion() {
        print(#function)
    }
    
    func sirenUserDidLaunchAppStore() {
        print(#function)
    }
    
    func sirenDidFailVersionCheck(error: Error) {
        print(#function, error)
    }
    
    func sirenLatestVersionInstalled() {
        print(#function, "Latest version of app is installed")
    }
    
    func sirenDidDetectNewVersionWithoutAlert(message: String) {
        print(#function, "\(message).\nRelease type")
    }
}

