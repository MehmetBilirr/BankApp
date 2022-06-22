//
//  DummyVC.swift
//  BankApp
//
//  Created by Mehmet Bilir on 22.06.2022.
//

import UIKit
import SnapKit

protocol LogoutViewConttollerDelegate:AnyObject {
    
    func didLogout()
}


class DummyVC: UIViewController {
    let stackView = UIStackView()
    let label = UILabel()
    let logOutButton = UIButton(type: .system)
    weak var delegate: LogoutViewConttollerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        style()
        layout()
        print(LocalState.hasLoggedin)

    }
    
    
    

    

}


extension DummyVC {
    func style() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.configuration = .filled()
        logOutButton.setTitle("Log Out", for: [])
        logOutButton.addTarget(self, action: #selector(logOutTapped(sender:)), for: .primaryActionTriggered)
        
    }
    
    func layout() {
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logOutButton)
        view.addSubview(stackView)
        
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.left.equalToSuperview().offset(100)
            make.right.equalToSuperview().offset(-100)
            make.bottom.equalToSuperview().offset(-400)
        }
        
        
        
    }
}

extension DummyVC {
    
    @objc func logOutTapped(sender:UIButton) {
        
        delegate?.didLogout()
    }
}
