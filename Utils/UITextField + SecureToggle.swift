//
//  UITextField + SecureToggle.swift
//  BankApp
//
//  Created by Mehmet Bilir on 26.06.2022.
//

import Foundation
import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField {
    
    func enablePasswordToggle(){
        
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView(_:)), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender:UIButton) {
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}


