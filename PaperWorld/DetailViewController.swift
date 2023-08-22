//
//  DetailViewController.swift
//  PaperWorld
//
//  Created by 闫润邦 on 2023/8/9.
//

import Foundation
import UIKit
import SceneKit

class DetailViewController: UIViewController {
    
    let sceneView = SCNView()
    let titleView = UILabel()
    let descriptorView = UITextView()
    var modelName = ""
    var descriptor = ""
    
    init(model: String, description: String) {
        modelName = model
        descriptor = description
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#FCE8D5FF")
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(clickMoreButton))
        configure(sceneView: sceneView, withModel: modelName)
        configure(titleView: titleView, withTitle: modelName)
        configure(descriptorView: descriptorView, withDescription: descriptor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem?.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationItem.rightBarButtonItem?.isHidden = true
    }
    
    private func configure(sceneView: SCNView, withModel model: String) {
        view.addSubview(sceneView)
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            sceneView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            sceneView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ]
        view.addConstraints(constraints)
        
        guard let scene = SCNScene(named: modelName + ".usdz") else {
            fatalError("failed to load " + modelName + ".usdz")
        }
        
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        scene.rootNode.addChildNode(lightNode)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)

        sceneView.allowsCameraControl = true
        sceneView.cameraControlConfiguration.allowsTranslation = false
        
        sceneView.scene = scene
    }
    
    private func configure(titleView: UILabel, withTitle title: String) {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            titleView.topAnchor.constraint(equalTo: sceneView.bottomAnchor, constant: 5),
            titleView.heightAnchor.constraint(equalToConstant: 60),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]
        
        view.addSubview(titleView)
        view.addConstraints(constraints)
        
        titleView.text = title
        titleView.numberOfLines = 0
        titleView.lineBreakMode = .byWordWrapping
        
        if let font = UIFont(name: "Grandstander-Bold", size: 20) {
            titleView.font = font
        } else {
            titleView.font = titleView.font.withSize(20)
            print("Unable to load font: Grandstander-Bold")
        }
        
    }
    
    private func configure(descriptorView: UITextView, withDescription description: String) {
        descriptorView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            descriptorView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 5),
            descriptorView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            descriptorView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            descriptorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        view.addSubview(descriptorView)
        view.addConstraints(constraints)
        
        descriptorView.text = description
        descriptorView.isEditable = false
        descriptorView.backgroundColor = .clear
        
        if let font = UIFont(name: "Grandstander-Light", size: 16) {
            descriptorView.font = font
        } else {
            descriptorView.font = descriptorView.font?.withSize(16)
            print("Unable to load font: Grandstander-Light")
        }
    }
    
    @objc private func clickMoreButton() {
        print("!@#")
    }

}
