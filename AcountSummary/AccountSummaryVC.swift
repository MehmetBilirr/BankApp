//
//  AccountSummaryVC.swift
//  BankApp
//
//  Created by Mehmet Bilir on 23.06.2022.
//

import UIKit
import SnapKit

class AccountSummaryVC: UIViewController {
    var accounts: [AccountSummaryTableViewCell.ViewModel] = []
    var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    

}


extension AccountSummaryVC {
    
    private func fetchAccounts() {
        let savings = AccountSummaryTableViewCell.ViewModel(accountType: .Banking,
                                                            accountName: "Basic Savings",
                                                            balance: 929466.23)
        let chequing = AccountSummaryTableViewCell.ViewModel(accountType: .Banking,
                                                             accountName: "No-Fee All-In Chequing",
                                                             balance: 17562.44)
        let visa = AccountSummaryTableViewCell.ViewModel(accountType: .CreditCard,
                                                         accountName: "Visa Avion Card",
                                                         balance: 412.83)
        let masterCard = AccountSummaryTableViewCell.ViewModel(accountType: .CreditCard,
                                                               accountName: "Student Mastercard",
                                                               balance: 50.83)
        let investment1 = AccountSummaryTableViewCell.ViewModel(accountType: .Investment,
                                                                accountName: "Tax-Free Saver",
                                                                balance: 2000.00)
        let investment2 = AccountSummaryTableViewCell.ViewModel(accountType: .Investment,
                                                                accountName: "Growth Fund",
                                                                balance: 15000.00)

        accounts.append(savings)
        accounts.append(chequing)
        accounts.append(visa)
        accounts.append(masterCard)
        accounts.append(investment1)
        accounts.append(investment2)
    }
    
    private func setup() {
        setupTableHeaderView()
        setupTableView()
        fetchAccounts()
    }
    
    private func setupTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountSummaryTableViewCell.self, forCellReuseIdentifier: AccountSummaryTableViewCell.identifier)
        tableView.rowHeight = AccountSummaryTableViewCell.rowHeight
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = appColor
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    private func setupTableHeaderView() {
        let header = AccountSummaryHeaderView(frame: .zero)
        
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        tableView.tableHeaderView = header
        
    }
}

extension AccountSummaryVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryTableViewCell.identifier, for: indexPath) as! AccountSummaryTableViewCell
        cell.configure(vm: accounts[indexPath.row])
        return cell
    }
    
    
}
