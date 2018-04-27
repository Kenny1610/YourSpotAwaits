//
//  AppDelegate.swift
//  YourSpotAwaits
//
//  Created by Kendall McCaskill on 4/4/18.
//  Copyright © 2018 YourSpotAwaits. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mask: CALayer?
    var imageView: UIImageView?
    
    let defaults = UserDefaults.standard
    var userIsLoggedIn: Bool?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let loginController = UINavigationController(rootViewController: LoginViewController())
        let viewController = UINavigationController(rootViewController: ViewController())

        
        GMSServices.provideAPIKey("AIzaSyAW7mXrNtPZ_Ytz4yZjLNh4W8Ep_5XARAo")
        
        FirebaseApp.configure()
        userIsLoggedIn = defaults.bool(forKey: "UserIsLoggedIn")
        
        if userIsLoggedIn == true {
             window?.rootViewController = viewController
        } else {
            window?.rootViewController = loginController
        }
        
        
        
//        let imageView = UIImageView(frame: self.window!.frame)
//        imageView.image = UIImage(named: "YSA-76")
//        self.window!.addSubview(imageView)
//
////        var maskedImage = UIImage.maskedImage(#imageLiteral(resourceName: "YSA-76"))
//
//        self.mask = CALayer()
//        self.mask!.contents = UIImage(named: "YSA-76" )?.cgImage
//        self.mask!.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
//        self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        self.mask!.position = CGPoint(x: imageView.frame.size.width/2, y: imageView.frame.size.height/2)
//
//        imageView.layer.mask = mask
//        self.imageView = imageView
//
//        animateMask()
//
//
//        // Override point for customization after application launch.
//        self.window!.backgroundColor = UIColor(red: 70/255, green: 154/255, blue: 233/255, alpha: 1)
//        self.window!.makeKeyAndVisible()
//        UIApplication.shared.isStatusBarHidden = true
        
        
        return true
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
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//    func animateMask() {
//        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
//        keyFrameAnimation.delegate = self as! CAAnimationDelegate
//        keyFrameAnimation.duration = 1
//        keyFrameAnimation.beginTime = CACurrentMediaTime() + 1 //add delay of 1 second
//        let initalBounds = NSValue(cgRect: mask!.bounds)
//        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 90, height: 90))
//        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 1500, height: 1500))
//        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
//        keyFrameAnimation.keyTimes = [0, 0.3, 1]
//        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
//        self.mask!.add(keyFrameAnimation, forKey: "bounds")
//    }
//
//     func animationDidStop(anim: CAAnimation, finished flag: Bool) {
//        self.imageView!.layer.mask = nil //remove mask when animation completes
//    }
    

}
//extension UIImage {
//    func maskedImage(mask: UIImage) -> UIImage {
//        guard
//            let imageReference = self.cgImage,
//            let maskReference = mask.cgImage,
//            let dataProvider = maskReference.dataProvider,
//            let imageMask = CGImage(
//                maskWidth: maskReference.width,
//                height: maskReference.height,
//                bitsPerComponent: maskReference.bitsPerComponent,
//                bitsPerPixel: maskReference.bitsPerPixel,
//                bytesPerRow: maskReference.bytesPerRow,
//                provider: dataProvider,
//                decode: nil,
//                shouldInterpolate: true
//            ),
//            let maskedReference = imageReference.masking(imageMask)
//            else { return mask }
//
//        return UIImage(cgImage: maskedReference)
//    }
//}

