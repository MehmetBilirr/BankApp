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
    let dummyVC = DummyVC()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self
        onboardingVC.delegate = self
        dummyVC.delegate = self
        
//        window?.rootViewController = loginViewController
//        window?.rootViewController = LoginViewController()
        
        
        if LocalState.hasLoggedin {
            window?.rootViewController = dummyVC
            
        }else{
            window?.rootViewController = loginViewController
        }
       
        
            
        
        
        
        
        return true
    }

   

}

extension AppDelegate {
    func setRootViewController(_ vc:UIViewController,animated:Bool = true) {
        guard animated,let window = self.window else {
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 1, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        
        LocalState.hasLoggedin = true
        
        
        if LocalState.hasOnboarded {
            setRootViewController(dummyVC)
        }else {
            setRootViewController(onboardingVC)
        }
        
    }
    
    
    
}

extension AppDelegate : OnboardingContainerVCDelegate {
    func didFinishOnboarding() {
        
        
        
        LocalState.hasOnboarded = true
        
        
        
        setRootViewController(dummyVC)
    }
    
    
}

extension AppDelegate:LogoutViewConttollerDelegate {
    func didLogout() {
        LocalState.hasLoggedin = false
        
        setRootViewController(loginViewController)
    }
    
    
}





