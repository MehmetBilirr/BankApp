//
//  OnboardingContainerVC.swift
//  BankApp
//
//  Created by Mehmet Bilir on 21.06.2022.
//

import UIKit
import SnapKit

class OnboardingContainerVC: UIViewController {

    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC:UIViewController {
        didSet{
            
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        let page1 = ViewController1()
        let page2 = ViewController2()
        let page3 = ViewController3()
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        currentVC = pages.first!
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemPurple
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        view.snp.makeConstraints { make in
            make.top.equalTo(pageViewController.view)
            make.left.equalTo(pageViewController.view)
            make.right.equalTo(pageViewController.view)
            make.bottom.equalTo(pageViewController.view)
        }
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false)
        currentVC = pages.first!
    }

    
    
}

extension OnboardingContainerVC:UIPageViewControllerDataSource {
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return getNextController(from: viewController)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return getPreviousController(from: viewController)
    }
    
    private func getPreviousController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        
        currentVC = pages[index - 1]
        return currentVC
    }

    private func getNextController(from viewController:UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return currentVC
        
        
    }
    
    func presentationCount(for pageViewController:UIPageViewController) -> Int {
        return pages.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
    
}

class ViewController1 : UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemRed
    }
}
class ViewController2 : UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemBlue
    }
}
class ViewController3 : UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemGreen
    }
}
