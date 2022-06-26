//
//  ViewController.swift
//  BankApp
//
//  Created by Mehmet Bilir on 20.06.2022.
//

import UIKit
import SnapKit

protocol LoginViewControllerDelegate: AnyObject {
    
    func didLogin()
}

final class LoginViewController: UIViewController {

    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    private let bankLbl : UILabel = UILabel()
    private let descLbl : UILabel = UILabel()
    private let stackView : UIStackView = UIStackView()
    let errorMessageLabel = UILabel()
    weak var delegate:LoginViewControllerDelegate?
    var username:String? {
        return loginView.usernameTextField.text
    }
    var password:String? {
        return loginView.passwordTextField.text
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        print(LocalState.hasLoggedin)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
    override func viewDidAppear(_ animated: Bool) {
        animate()
        
    }


}


extension LoginViewController {
    
    private func style() {
        bankLbl.text = "BankApp"
        bankLbl.textAlignment = .center
        bankLbl.font = UIFont(name: "Helvetica-Bold", size: 30)
        
        descLbl.text = "Bank is on your mobilephone for free!"
        descLbl.numberOfLines = 0
        descLbl.lineBreakMode = .byWordWrapping
        descLbl.textAlignment = .center
        descLbl.font = UIFont.systemFont(ofSize: 20)
        
        stackView.axis = .vertical
        stackView.spacing = 40
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped(sender:)), for: .primaryActionTriggered)
        
        
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.font = UIFont.systemFont(ofSize: 15)
        errorMessageLabel.textColor = .red
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.lineBreakMode = .byWordWrapping
        errorMessageLabel.isHidden = true
        
        
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    private func layout() {
        
        view.addSubview(loginView)
        stackView.addArrangedSubview(bankLbl)
        stackView.addArrangedSubview(descLbl)
        view.addSubview(stackView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(250)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            
            
            
            
            
            
        }
        
        
        loginView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(50)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(loginView.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        errorMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
    }
    
    
}

extension LoginViewController {
    @objc func signInTapped(sender:UIButton) {
        
        errorMessageLabel.isHidden = true
        login()
        
    }
    private func login() {
        
        guard let username = username, let password = password else {return}
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be empty")
        }
        
        if username == "" && password == "" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
            
        }else {
            configureView(withMessage: "Incorrect username / password")
        }
        
    }
    
    private func configureView(withMessage message : String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        shakeButton(signInButton)
    }
    

}

extension LoginViewController {
    private func animate() {
        
        UIView.animate(withDuration: 0) {
            self.bankLbl.transform = CGAffineTransform(translationX: -500 , y: 0 )
            self.descLbl.transform = CGAffineTransform(translationX: -500, y: 0)
        } completion: { (true) in
            UIView.animate(withDuration: 1) {
                self.bankLbl.transform = CGAffineTransform(translationX: 0, y: 0)
            } completion: { (true) in
                
                UIView.animate(withDuration: 1) {
                    self.descLbl.transform = CGAffineTransform(translationX: 0, y: 0)
                }

            }

        }

    }
    
    private func shakeButton(_ sender :UIButton ) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: sender.center.x - 10, y: sender.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: sender.center.x + 10, y: sender.center.y))
        sender.layer.add(animation, forKey: "position")
    }
}
