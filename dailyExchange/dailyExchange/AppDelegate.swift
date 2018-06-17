//
//  AppDelegate.swift
//  dailyExchange
//
//  Created by thomas minshull on 2018-03-05.
//  Copyright © 2018 thomas minshull. All rights reserved.
//

import UIKit
import Parse
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    lazy var registerParseSubclasses: () = {
        // Lazy instanciation insures that this block of code only runs once
        ExchangeRateParseObject.registerSubclass()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loadMainStoryboard),
                                               name: Notification.Name.didLogIn,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loadLoginStoryboard),
                                               name: Notification.Name.didLogout,
                                               object: nil)
        _ = registerParseSubclasses
        
        let configuration = ParseClientConfiguration
        {
            $0.applicationId = APPLICATION_ID
            $0.clientKey = MASTER_KEY
            $0.server = SERVER
            $0.isLocalDatastoreEnabled = true
        }
        
        Parse.initialize(with: configuration)
        
        if PFUser.current() != nil
        {   // user is logged in
            loadMainStoryboard()
        } else
        {   // user needs to login
            loadLoginStoryboard()
        }
        
        registerForPushNotifications()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.didLogIn,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.didLogout,
                                                  object: nil)
    }

    func applicationWillEnterForeground(_ application: UIApplication)
    {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loadMainStoryboard),
                                               name: Notification.Name.didLogIn,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loadLoginStoryboard),
                                               name: Notification.Name.didLogout,
                                               object: nil)
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.didLogIn,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.didLogout,
                                                  object: nil)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        
        let installation = PFInstallation.current()
        installation?.setDeviceTokenFrom(deviceToken)
        installation?.saveInBackground()
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    // MARK: - Helper Methods
    
    private func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge ,.sound]) { (success, error) in
            guard error == nil else {
                print("Error occured while requesting Authorization for Push Notifications: \(error!)")
                return
            }
            if (success) {
                print("Push Notification Access Granted")
                self.getNotificationSettings()
            } else {
                print("Push Notification Access Denied")
            }
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    @objc private func loadLoginStoryboard()
    {
        let mainStoryboard = UIStoryboard(name: "Login", bundle: nil)
        window!.rootViewController = mainStoryboard.instantiateInitialViewController()
    }
    
    @objc private func loadMainStoryboard()
    {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        window!.rootViewController = mainStoryboard.instantiateInitialViewController()
    }
}

