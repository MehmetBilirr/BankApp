//
//  OnboardingContainerVC.swift
//  BankApp
//
//  Created by Mehmet Bilir on 21.06.2022.
//

import UIKit
import SnapKit

protocol OnboardingContainerVCDelegate:AnyObject{
    func didFinishOnboarding()
}

class OnboardingContainerVC: UIViewController {

    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    
    let closeButton = UIButton(type: .system)
    let backButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let doneButton = UIButton(type: .system)
    weak var delegate: OnboardingContainerVCDelegate?
    var currentVC:UIViewController {
        didSet {
            guard let index = pages.firstIndex(of: currentVC) else {return}
            nextButton.isHidden = index == pages.count - 1
            backButton.isHidden = index == 0
            doneButton.isHidden = !(index == pages.count - 1)
        }
    }
    
    
        
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        let page1 = OnBoardingVC(imageName: "bank", descLabel: "aıdsjal adj asd kajsd kjahdj habsjhdb ajhsdb ajhsbd ajbdh")
        let page2 = OnBoardingVC(imageName: "money", descLabel: "ajdsasd ahd jahsdj hahjdh ajhd jahsdh ahsbd habsd habsd hab sdh bahsd bahsdb h")
        let page3 = OnBoardingVC(imageName: "transfer", descLabel: "aıdja ajd ahd jasdj abhdb ahsdb ahsbd ahbd hasbd ")
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
        
        setup()
        style()
        layout()
        
        
        
        
        
    }
    
    private func setup() {
        
        view.backgroundColor = .systemBlue
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
    
    private func style() {
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(closeTapped(_:)), for: .primaryActionTriggered)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: [])
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .primaryActionTriggered)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back", for: [])
        backButton.addTarget(self, action: #selector(backTapped(_:)), for: .primaryActionTriggered)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: [])
        doneButton.addTarget(self, action: #selector(doneTapped(_:)), for: .primaryActionTriggered)
        view.addSubview(closeButton)
        view.addSubview(nextButton)
        view.addSubview(backButton)
        view.addSubview(doneButton)
        
    }
    
    private func layout() {
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(8)
            
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.right.equalToSuperview().offset(-10)
            
        }
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.right.equalToSuperview().offset(-10)
            
        }
        
        backButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.left.equalToSuperview().offset(10)
        }
        
        
        
        
        
    }

    
    
}

extension OnboardingContainerVC:UIPageViewControllerDataSource {
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return getNextController(viewController: viewController)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return getPreviousController(viewController: viewController)
    }
    
    private func getPreviousController(viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        
        currentVC = pages[index - 1]
        return currentVC
    }

    private func getNextController(viewController:UIViewController) -> UIViewController? {
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


extension OnboardingContainerVC {
    @objc func closeTapped (_ sender:UIButton) {
        
        delegate?.didFinishOnboarding()
    }
    
    @objc func nextTapped(_ sender:UIButton) {
        
        guard let nextVC = getNextController(viewController: currentVC) else {return}
        pageViewController.setViewControllers([nextVC], direction: .forward, animated: true)
        
    }
    
    @objc func backTapped(_ sender:UIButton) {
        guard let nextVC = getPreviousController(viewController: currentVC) else {return}
        pageViewController.setViewControllers([nextVC], direction: .reverse, animated: true)
        
    }
    
    @objc func doneTapped(_ sender:UIButton) {
        
        delegate?.didFinishOnboarding()
    }
}
