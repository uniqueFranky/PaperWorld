//
//  ViewController.swift
//  PaperWorld
//
//  Created by 闫润邦 on 2023/8/8.
//

import UIKit
import SceneKit

class IndexViewController: UIViewController {
    let headerView = UIView()
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        initHeaderView(headerView)
        
    }
    
    private func initHeaderView(_ superView: UIView) {
        let avatarView = UIImageView(image: UIImage(named: "avatar.jpg"))
        let hintView = UILabel()
        let nameView = UILabel()
        let logoView = UIImageView(image: UIImage(named: "museum.jpg"))
        let settingButton = UIImageView(image: UIImage(systemName: "gearshape"))
        
        
        view.addSubview(superView)
        headerView.addSubview(avatarView)
        headerView.addSubview(hintView)
        headerView.addSubview(nameView)
        headerView.addSubview(logoView)
        headerView.addSubview(settingButton)
        
        
        superView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        hintView.translatesAutoresizingMaskIntoConstraints = false
        nameView.translatesAutoresizingMaskIntoConstraints = false
        logoView.translatesAutoresizingMaskIntoConstraints = false
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            avatarView.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 20),
            avatarView.centerYAnchor.constraint(equalTo: superView.centerYAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 40),
            avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor),
            
            nameView.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 10),
            nameView.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            nameView.heightAnchor.constraint(equalToConstant: 20),
            nameView.widthAnchor.constraint(equalToConstant: 100),
            
            hintView.leadingAnchor.constraint(equalTo: nameView.leadingAnchor),
            hintView.topAnchor.constraint(equalTo: superView.topAnchor),
            hintView.bottomAnchor.constraint(equalTo: nameView.topAnchor),
            hintView.widthAnchor.constraint(equalToConstant: 100),
            
            logoView.centerXAnchor.constraint(equalTo: superView.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: superView.topAnchor),
            logoView.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 64.13),
            
            settingButton.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -20),
            settingButton.topAnchor.constraint(equalTo: superView.topAnchor),
            settingButton.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            settingButton.widthAnchor.constraint(equalTo: superView.heightAnchor),
            
            superView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            superView.heightAnchor.constraint(equalToConstant: 50),
            superView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            superView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        view.addConstraints(constraints)
        
        hintView.text = "Hello"
        if let font = UIFont(name: "Grandstander-Light", size: 11) {
            hintView.font = font
        } else {
            hintView.font = hintView.font.withSize(11)
            print("Unable to load font: Grandstander-Light")
        }
        
        nameView.text = "Fate"
        if let font = UIFont(name: "Grandstander-Regular", size: 16) {
            nameView.font = font
        } else {
            nameView.font = nameView.font.withSize(16)
            print("Unable to load font: Grandstander-Regular")
        }
    }

}

