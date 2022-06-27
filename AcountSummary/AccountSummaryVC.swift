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
    var accounts:[Account] = []
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
                
                self.profile = profile
                self.configureTableHeaderView(profile: profile)
                self.tableView.reloadData()
                
            case.failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
        fetchAccounts(userID: "1") { result in
            switch result {
            case.success(let accounts):
                self.accounts = accounts
                print("mehmet\(accounts.first)")
                self.configureTableCells(accounts: accounts)
                self.tableView.reloadData()
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func configureTableHeaderView(profile:Profile) {
        
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,", name: profile.firstName, date: Date())
        headerView.configure(viewModel: vm)
    }
    
    private func configureTableCells(accounts:[Account]) {
        accountCellViewModels = accounts.map {
            AccountSummaryTableViewCell.ViewModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)
        }
    }
    
}
