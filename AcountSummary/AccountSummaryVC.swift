//
//  AccountSummaryVC.swift
//  BankApp
//
//  Created by Mehmet Bilir on 23.06.2022.
//

import UIKit
import SnapKit

class AccountSummaryVC: UIViewController {
    // Request Models
    var profile:Profile?
    var accounts:[Account] = []
    var isLoaded = false
    
    //View Models
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
    var accountCellViewModels: [AccountSummaryTableViewCell.ViewModel] = []
    
    //Components
    var tableView = UITableView()
    var headerView = AccountSummaryHeaderView(frame: .zero)
    let refreshControl = UIRefreshControl()
    lazy var logoutBarButtonItem :UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped(_:)))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        
        
    }
    
    
    

}


extension AccountSummaryVC {
    
    
    private func setup() {
        setupNavigationBar()
        setupTableHeaderView()
        setupTableView()
        fetchData()
        setupRefreshControl()

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
    
    private func setupNavigationBar(){
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    private func setupRefreshControl() {
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = refreshControl
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
    private func fetchData() {
        
        let group = DispatchGroup()
        let userID = String(Int.random(in: 1..<4))
        
        group.enter()
        fetchProfile(userID: userID) { result in
            switch result {
            case .success(let profile):
                
                self.profile = profile
                
                
                
            case.failure(let error):
                print(error.localizedDescription)
                
            }
            group.leave()
        }
        
        
        
        group.enter()
        fetchAccounts(userID: userID) { result in
            switch result {
            case.success(let accounts):
                self.accounts = accounts
                
                
                
                
            case.failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.refreshControl?.endRefreshing()
            guard let profile = self.profile else {return}
            self.configureTableHeaderView(profile: profile)
            self.configureTableCells(accounts: self.accounts)
            self.isLoaded = true
            self.tableView.reloadData()
            
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

// Actions
extension AccountSummaryVC {
    
    @objc func logoutTapped(_ sender:UIButton) {
        
        NotificationCenter.default.post(name: .logout, object: nil)
        
    }
    
    @objc func refreshContent() {
        reset()
        tableView.reloadData()
        fetchData()
    }
    
    private func reset() {
        profile = nil
        accounts = []
        isLoaded = false
    }
    
}
