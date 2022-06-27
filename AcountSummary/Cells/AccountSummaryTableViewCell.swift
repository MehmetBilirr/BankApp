//
//  AccountSummaryTableViewCell.swift
//  BankApp
//
//  Created by Mehmet Bilir on 23.06.2022.
//

import UIKit
import SnapKit

enum AccountType:String,Codable {
    case Banking
    case CreditCard
    case Investment
}

class AccountSummaryTableViewCell: UITableViewCell {
    
    
    enum BalanceType:String {
        
        case currentBalance = "Current Balance"
        case value = "Value"
        
        
    }
    
    struct ViewModel {
        let accountType:AccountType
        let accountName:String
        let balance:Decimal
        
        var balanceAsAttributedString : NSAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    
    static let identifier = "AccountSummaryTableViewCell"
    static let rowHeight : CGFloat = 112
    let typeLabel = UILabel()
    let nameLabel = UILabel()
    let dividerView = UIView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    let chevronImageView = UIImageView()
    let stackView = UIStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

extension AccountSummaryTableViewCell {
    
    private func setup(){
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.text = "Account type"
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(typeLabel)
        
        dividerView.backgroundColor = appColor
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dividerView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.text = "Account name"
        nameLabel.adjustsFontSizeToFitWidth = true
        contentView.addSubview(nameLabel)
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.text = "Some balance"
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceAmountLabel.attributedText = CurrencyFormatter().makeAttributedCurrency(92993.23)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.addArrangedSubview(balanceLabel)
        stackView.addArrangedSubview(balanceAmountLabel)
        contentView.addSubview(stackView)
        
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(systemName: "chevron.right")!.withTintColor(appColor, renderingMode: .alwaysOriginal)
        chevronImageView.image = chevronImage
        contentView.addSubview(chevronImageView)
        
        
        
        
        
        
    }
    
    private func layout(){
        
        
        
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(5)
            make.left.equalTo(contentView).offset(5)
            
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(5)
            make.left.equalTo(typeLabel.snp.left)
            make.right.equalTo(typeLabel.snp.right).offset(5)
            make.height.equalTo(2)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(20)
            make.left.equalTo(typeLabel.snp.left)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(10)
            make.right.equalTo(contentView).offset(-30)
            
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(20)
            make.left.equalTo(stackView.snp.right).offset(10)
        }
        
    }
    
    
    
    func configure(vm:ViewModel) {
        
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        switch vm.accountType {
            
        case .Banking:
            dividerView.backgroundColor = appColor
            balanceLabel.text = BalanceType.currentBalance.rawValue
            
        case .CreditCard:
            dividerView.backgroundColor = .systemOrange
            balanceLabel.text = BalanceType.currentBalance.rawValue
        case .Investment:
            dividerView.backgroundColor = .systemPurple
            balanceLabel.text = BalanceType.value.rawValue
        }
    }
    
    
}



