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
    @IBOutlet weak var WelcomeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    let shakeyBellView = ShakeyBellView()
    
    struct ViewModel {
        let welcomeMessage:String
        let name:String
        let date:Date
        
        var dateFormatted : String {
            return date.monthDayYearString
        }
    }
    
    
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
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.backgroundColor = appColor
        
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        setupShakeyBell()
    }
    
    private func setupShakeyBell(){
        shakeyBellView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shakeyBellView)
        
        shakeyBellView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func configure(viewModel:ViewModel) {
        WelcomeLbl.text = viewModel.welcomeMessage
        nameLbl.text = viewModel.name
        dateLbl.text = viewModel.dateFormatted
    }
}



