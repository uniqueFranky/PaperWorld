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
    
    let settingViewController = SettingViewController()
    let profileViewController = ProfileViewController()
    
    let names = ModelDatas.names
    let colors = ModelDatas.colors
    let simpleDescriptions = ModelDatas.simpleDescriptions
    let descriptions = ModelDatas.descriptions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(hex: "#FCE8D5FF")
        title = "首页"
        configure(headerView: headerView)
        configure(tableView: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func configure(headerView: UIView) {
        let avatarView = UIButton(type: .custom)
        let hintView = UILabel()
        let nameView = UILabel()
        let logoView = UIImageView(image: UIImage(named: "museum.jpg"))
        let settingButton = UIButton(type: .system)
        
        view.addSubview(headerView)
        headerView.addSubview(avatarView)
        headerView.addSubview(hintView)
        headerView.addSubview(nameView)
        headerView.addSubview(logoView)
        headerView.addSubview(settingButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        hintView.translatesAutoresizingMaskIntoConstraints = false
        nameView.translatesAutoresizingMaskIntoConstraints = false
        logoView.translatesAutoresizingMaskIntoConstraints = false
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            avatarView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            avatarView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 40),
            avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor),
            
            nameView.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 10),
            nameView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            nameView.heightAnchor.constraint(equalToConstant: 20),
            nameView.widthAnchor.constraint(equalToConstant: 100),
            
            hintView.leadingAnchor.constraint(equalTo: nameView.leadingAnchor),
            hintView.topAnchor.constraint(equalTo: headerView.topAnchor),
            hintView.bottomAnchor.constraint(equalTo: nameView.topAnchor),
            hintView.widthAnchor.constraint(equalToConstant: 100),
            
            logoView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: headerView.topAnchor),
            logoView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 64.13),
            
            settingButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            settingButton.topAnchor.constraint(equalTo: headerView.topAnchor),
            settingButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            settingButton.widthAnchor.constraint(equalTo: headerView.heightAnchor),
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        view.addConstraints(constraints)
        
        avatarView.setImage(UIImage(data: (UserData.fetchAvatar() ?? UIImage(named: "avatar.jpg")!.pngData()!)), for: .normal)
        
        hintView.text = "Hello"
        if let font = UIFont(name: "Grandstander-Light", size: 11) {
            hintView.font = font
        } else {
            hintView.font = hintView.font.withSize(11)
            print("Unable to load font: Grandstander-Light")
        }
        
        nameView.text = UserData.fetchUserName() ?? "No Name"
        if let font = UIFont(name: "Grandstander-Regular", size: 16) {
            nameView.font = font
        } else {
            nameView.font = nameView.font.withSize(16)
            print("Unable to load font: Grandstander-Regular")
        }
        
        avatarView.addTarget(self, action: #selector(clickAvatar), for: .touchUpInside)
        settingButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingButton.addTarget(self, action: #selector(clickSettingButton), for: .touchUpInside)
    }
    
    func configure(tableView: UITableView) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(IndexListCell.self, forCellReuseIdentifier: IndexListCell.reuseIdentifier)
        tableView.rowHeight = 200
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        let constraints = [
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        view.addConstraints(constraints)
        
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
    }
    
    @objc func clickSettingButton() {
        self.navigationController?.pushViewController(settingViewController, animated: true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc func clickAvatar() {
        self.navigationController?.pushViewController(profileViewController, animated: true)
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension IndexViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IndexListCell.reuseIdentifier, for: indexPath) as! IndexListCell
        cell.configureContents(withModel: names[indexPath.row], ofColor: colors[indexPath.row % colors.count]!, withSimpleDescription: simpleDescriptions[indexPath.row])
        return cell
    }
}

extension IndexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        let detailViewController = DetailViewController(model: names[indexPath.row], description: descriptions[indexPath.row])
        navigationController?.pushViewController(detailViewController, animated: true)
        navigationController?.isNavigationBarHidden = false
    }
}

class IndexListCell: UITableViewCell {
    static let reuseIdentifier = "index-list-cell"
    let myImageView = UIImageView()
    let titleView = UILabel()
    let descriptorView = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    func configureContents(withModel modelName: String, ofColor color: UIColor, withSimpleDescription description: String) {
        self.backgroundColor = .clear
        contentView.clipsToBounds = true
        myImageView.image = UIImage(named: modelName + ".png")
        titleView.text = modelName
        descriptorView.text = description
        
        contentView.addSubview(myImageView)
        contentView.addSubview(titleView)
        contentView.addSubview(descriptorView)
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        descriptorView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            myImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            myImageView.heightAnchor.constraint(equalToConstant: 196),
            myImageView.widthAnchor.constraint(equalToConstant: 165),
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            
            titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleView.heightAnchor.constraint(equalToConstant: 20),
            titleView.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 10),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            descriptorView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10),
            descriptorView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            descriptorView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            descriptorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        contentView.addConstraints(constraints)
        
        descriptorView.numberOfLines = 0
        descriptorView.lineBreakMode = .byWordWrapping
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = color
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
