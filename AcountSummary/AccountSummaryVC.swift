//
//  AccountSummaryVC.swift
//  BankApp
//
//  Created by Mehmet Bilir on 23.06.2022.
//

import UIKit
import SnapKit

class AccountSummaryVC: UIViewController {
    
    var profile:Profile?
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
    var accountCellViewModels: [AccountSummaryTableViewCell.ViewModel] = []
    var tableView = UITableView()
    var headerView = AccountSummaryHeaderView(frame: .zero)
    lazy var logoutBarButtonItem :UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped(_:)))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavigationBar()
        
        
    }
    
    func setupNavigationBar(){
        navigationItem.rightBarButtonItem = logoutBarButtonItem
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

        accountCellViewModels.append(savings)
        accountCellViewModels.append(chequing)
        accountCellViewModels.append(visa)
        accountCellViewModels.append(masterCard)
        accountCellViewModels.append(investment1)
        accountCellViewModels.append(investment2)
    }
    
    private func setup() {
        setupTableHeaderView()
        setupTableView()
        fetchDataAndLoadViews()

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
        
        
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        tableView.tableHeaderView = headerView
        
    }
}

extension AccountSummaryVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryTableViewCell.identifier, for: indexPath) as! AccountSummaryTableViewCell
        cell.configure(vm: accountCellViewModels[indexPath.row])
        return cell
    }
    
    
}

extension AccountSummaryVC {
    
    @objc func logoutTapped(_ sender:UIButton) {
        
        NotificationCenter.default.post(name: .logout, object: nil)
        
    }
    
}

extension AccountSummaryVC {
    private func fetchDataAndLoadViews() {
        
        fetchProfile(userID: "1") { result in
            switch result {
            case .success(let profile):
                print("mehmet\(profile)")
                self.profile = profile
                self.configureTableHeaderView(profile: profile)
                self.tableView.reloadData()
                
            case.failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
        fetchAccounts()
        
    }
    
    private func configureTableHeaderView(profile:Profile) {
        
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,", name: profile.firstName, date: Date())
        headerView.configure(viewModel: vm)
    }
}
