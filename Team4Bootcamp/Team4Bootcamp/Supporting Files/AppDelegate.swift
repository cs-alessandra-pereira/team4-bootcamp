//
//  AppDelegate.swift
//  Team4Bootcamp
//
//  Created by alessandra.l.pereira on 27/03/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coredata = CoreDataHelper()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        coredata.saveContext()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        coredata.saveContext()
    }

}
