//
//  OnBoardingVC.swift
//  BankApp
//
//  Created by Mehmet Bilir on 21.06.2022.
//

import UIKit

class OnBoardingVC: UIViewController {
    let stackView = UIStackView()
    let label = UILabel()
    var imageView = UIImageView()
    let descLabel : String
    let imageName : String
    
    init(imageName:String,descLabel:String) {
        self.imageName = imageName
        self.descLabel = descLabel
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        layout()
    }
    
    

    

}

extension OnBoardingVC {
    
    private func style() {
        view.backgroundColor = .systemBackground
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = descLabel
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView = UIImageView(frame: CGRect(x: stackView.center.x, y: stackView.center.y, width: 100, height: 100))
        imageView.image = UIImage(named:imageName)
        
        
        
    }
    
    private func layout() {
        
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(200)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(400)
            
            
        }
        
        
    }
}
