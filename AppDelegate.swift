//
//  AppDelegate.swift
//  BankApp
//
//  Created by Mehmet Bilir on 20.06.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    

    let loginViewController = LoginViewController()
    let onboardingVC = OnboardingContainerVC()
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self
        onboardingVC.delegate = self
        
//        window?.rootViewController = loginViewController
//        window?.rootViewController = LoginViewController()
        window?.rootViewController = onboardingVC
        
        
        return true
    }

   

}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        print("Did login")
    }
    
    
    
}

extension AppDelegate : OnboardingContainerVCDelegate {
    func didFinishOnboarding() {
        print("did on boarding")
    }
    
    
}

