//
//  ShakeyBellView.swift
//  BankApp
//
//  Created by Mehmet Bilir on 27.06.2022.
//

import Foundation
import UIKit
import SnapKit


class ShakeyBellView:UIView {
    let imageView = UIImageView()
    let buttonView = UIButton()
    let buttonHeight:CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
}

extension ShakeyBellView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "bell.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.image = image
        
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.backgroundColor = .systemRed
        buttonView.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        buttonView.layer.cornerRadius = buttonHeight/2
        buttonView.setTitle("9", for: .normal)
        buttonView.setTitleColor(.white, for: .normal)
    }
    
    func layout(){
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        addSubview(buttonView)
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top)
            make.right.equalTo(imageView.snp.right).offset(5)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
    }
    
    func setup (){
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView.addGestureRecognizer(singleTap)
        imageView.isUserInteractionEnabled = true
    }
}

extension ShakeyBellView {
    @objc func imageViewTapped(_ recognizer:UITapGestureRecognizer) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    
}
