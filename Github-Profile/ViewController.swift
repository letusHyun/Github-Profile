//
//  ViewController.swift
//  Github-Profile
//
//  Created by SeokHyun on 2022/12/29.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

  let nameLabel: UILabel = {
    let name = UILabel()
    name.text = "Name"
    name.textColor = .black
    name.font = .systemFont(ofSize: 20)
    return name
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    
  }
  
  func configureUI() {
    view.addSubview(nameLabel)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    
  }

}

