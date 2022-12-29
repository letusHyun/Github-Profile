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
//MARK: Property
  private(set) var user: UserProfile?
  
  let thumbnailImageView = UIImageView().then {
    $0.image = UIImage(systemName: "sun.min.fill")
    $0.backgroundColor = .systemCyan
  }
  
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
    setUpUI()

  }
  
  //viewDidLoad에서는 bound, frame 접근 불가능
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.width / 2
  }
  
  //MARK: Layout
  private func setUpView() {
    self.view.addSubview(thumbnailImageView)
    self.view.addSubview(nameLabel)
    self.view.addSubview(loginLabel)
    self.view.addSubview(followerLabel)
    self.view.addSubview(followingLabel)
  }
  
  private func setUpUI() {
    
  }
  
  private func setUpConstraints() {
    
    thumbnailImageView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(nameLabel.snp.top).offset(-40)
      $0.width.height.equalTo(150)
    }
    
    nameLabel.snp.makeConstraints {
      $0.leading.equalTo(self.view).offset(30)
      $0.centerY.equalTo(self.view)
    }
    
    loginLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(10)
      $0.leading.equalTo(self.view).offset(30)
    }
    
    followerLabel.snp.makeConstraints {
      $0.top.equalTo(loginLabel.snp.bottom).offset(30)
      $0.leading.equalTo(self.view).offset(30)
    }
    
    followingLabel.snp.makeConstraints {
      $0.top.equalTo(followerLabel.snp.bottom).offset(10)
      $0.leading.equalTo(self.view).offset(30)
    }
  }

  
  /*
   setupUI
   userProfile
   bind
   search control
   network
   */
  
}

