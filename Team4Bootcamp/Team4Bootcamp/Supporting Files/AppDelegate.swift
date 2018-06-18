//
//  AppDelegate.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 27/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coredata = CoreDataHelper()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        KingfisherManager.shared.cache.maxMemoryCost = 5_000_000
        KingfisherManager.shared.cache.maxDiskCacheSize = 50_000_000
        
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        coredata.saveContext()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        coredata.saveContext()
    }

}
