//
//  LoginView.swift
//  BankApp
//
//  Created by Mehmet Bilir on 20.06.2022.
//


import UIKit
import Foundation
import SnapKit
class LoginView: UIView {
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    private let stackView = UIStackView()
    private let betweenView = UIView()
    
    override init (frame: CGRect) {
        super.init(frame:frame)
        style()
        layout()
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}




extension LoginView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Username"
        usernameTextField.delegate = self
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
        
        betweenView.translatesAutoresizingMaskIntoConstraints = false
        betweenView.backgroundColor = .secondarySystemFill
        betweenView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        stackView.axis = .vertical
        stackView.spacing = 8
        layer.cornerRadius = 8
        clipsToBounds = true
        
    }
    
    func layout() {
        addSubview(stackView)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(betweenView)
        stackView.addArrangedSubview(passwordTextField)
        
        
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
    }
}

extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

