//
//  AccountSummaryHeaderView.swift.swift
//  BankApp
//
//  Created by Mehmet Bilir on 23.06.2022.
//

import UIKit
import SnapKit

class AccountSummaryHeaderView:UIView {
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        commonInit()
    }
    
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    
    private func commonInit() {
        let bundle = Bundle(for: AccountSummaryVC.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self)
        addSubview(contentView)
        contentView.backgroundColor = appColor
        
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
}



