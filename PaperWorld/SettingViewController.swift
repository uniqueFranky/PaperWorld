//
//  SettingViewController.swift
//  PaperWorld
//
//  Created by 闫润邦 on 2023/8/9.
//

import Foundation
import UIKit

class SettingViewController: UIViewController {
    
    let tableView = UITableView()
    let titles = ["通知设置", "青少年设置", "深色模式", "打印设置"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "设置"
        view.backgroundColor = UIColor(hex: "#FCE8D5FF")
        configure(tableView: tableView)
    }
    
    private func configure(tableView: UITableView) {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 200),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        view.addConstraints(constraints)
        
        tableView.backgroundColor = .clear
        tableView.rowHeight = 50
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 15
        tableView.clipsToBounds = true
        tableView.separatorStyle = .none
        
        tableView.register(SettingListCell.self, forCellReuseIdentifier: SettingListCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self

    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingListCell.reuseIdentifier, for: indexPath) as! SettingListCell
        cell.configure(withTitle: titles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
    }
}

class SettingListCell: UITableViewCell {
    static let reuseIdentifier = "setting-list-cell"
    let label = UILabel()
    func configure(withTitle title: String) {
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        let constraints = [
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        contentView.addConstraints(constraints)
        self.backgroundColor = UIColor(hex: "#F8EC7EFF")
        self.accessoryType = .disclosureIndicator
    }
}

