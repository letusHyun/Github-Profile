//
//  ViewController.swift
//  Github-Profile
//
//  Created by SeokHyun on 2022/12/29.
//

import UIKit
import SnapKit
import Then

class UserProfileViewController: UIViewController {

//  let thumbnailImageView = UIImageView().then {
//    <#code#>
//  }
  
  let nameLabel = UILabel().then {
    $0.text = "Name"
    $0.textColor = .black
    $0.font = .systemFont(ofSize: 20)
  }
  
  let loginLabel = UILabel().then {
    $0.text = "Github id"
    $0.textColor = .systemGray
    $0.font = .systemFont(ofSize: 15)
  }
  
  let followerLabel = UILabel().then {
    $0.text = "followers: 0"
    $0.textColor = .systemGray
    $0.font = .systemFont(ofSize: 15)
  }
  
  let followingLabel = UILabel().then {
    $0.text = "following: 0"
    $0.textColor = .systemGray
    $0.font = .systemFont(ofSize: 15)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpView()
    setUpConstraints()
  }
  
  private func setUpView() {
    self.view.addSubview(nameLabel)
    self.view.addSubview(loginLabel)
    self.view.addSubview(followerLabel)
    self.view.addSubview(followingLabel)
//    self.view.addSubview(thumbnailImageView)
  }
  
  private func setUpConstraints() {
    nameLabel.snp.makeConstraints {
      $0.leading.equalTo(self.view).offset(30)
      $0.centerY.equalTo(self.view)
    }
    
    loginLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(10)
      $0.leading.equalTo(self.view).offset(30)
    }
    
    followerLabel.snp.makeConstraints {
      $0.top.equalTo(loginLabel.snp.bottom).offset(10)
      $0.leading.equalTo(self.view).offset(30)
    }
    
    followingLabel.snp.makeConstraints {
      $0.top.equalTo(followerLabel.snp.bottom).offset(10)
      $0.leading.equalTo(self.view).offset(30)
    }
    
  }

}

