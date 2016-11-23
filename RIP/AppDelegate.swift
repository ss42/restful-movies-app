//
//  AppDelegate.swift
//  RIP
//
//  Created by Brian Hill on 11/22/16.
//  Copyright © 2016 cs197. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    var endpointURL: URL = URL(string: "http://localhost:8080/product/0767026128/reviews")!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.delegate = self
        //parseJSON()
        return true
    }
//    func parseJSON(){
//        print("parsing json")
//        let task = URLSession.shared.dataTask(with: endpointURL, completionHandler:{
//            (data, response, error) -> Void in
//            let httpResponse = response as! HTTPURLResponse
//            let statusCode = httpResponse.statusCode
//            print(statusCode)
//            if statusCode == 200{
//                do{
//                    let json  = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
//                    if let membersDict = json as? [String: Any]{
//                        let members = membersDict["reviews"] as? [[String: Any]]
//                        for member in members!{
//                            let productId = member["product_id"] as! String
//                            let summary = member["summary"] as! String
//                            let rating = member["rating"] as! Int
//                            let text = member["text"] as! String
//                            
//                            
//                            var memberClass = Member(product_id: productId, summary: summary, rating: rating, text: text)
//                            //self.objects.append(memberClass)
//                            print(memberClass.summary)
//                        }
//                    }
//                    
//                }
//                catch{
//                    print("error with JSON")
//                }
//            }
//        })
//        task.resume()
//        
//    }
  
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
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Split view

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }

}

