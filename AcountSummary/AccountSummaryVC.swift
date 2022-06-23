//
//  AccountSummaryVC.swift
//  BankApp
//
//  Created by Mehmet Bilir on 23.06.2022.
//

import UIKit
import SnapKit

class AccountSummaryVC: UIViewController {
    let games = ["Pacman","Space Invaders","Space Patrol"]
    var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    

}


extension AccountSummaryVC {
    
    private func setup() {
        setupTableHeaderView()
        setupTableView()
        
    }
    
    private func setupTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountSummaryTableViewCell.self, forCellReuseIdentifier: AccountSummaryTableViewCell.identifier)
        tableView.rowHeight = AccountSummaryTableViewCell.rowHeight
        tableView.tableFooterView = UIView()
        
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
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryTableViewCell.identifier, for: indexPath) as! AccountSummaryTableViewCell
        
        return cell
    }
    
    
}
