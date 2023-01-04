//
//  ViewController.swift
//  Github-Profile
//
//  Created by SeokHyun on 2022/12/29.
//

import UIKit
import SnapKit
import Then
import Combine
import Kingfisher

class UserProfileViewController: UIViewController {
  
//MARK: - Property
  var viewModel: SearchViewModel!
  
  let thumbnailImageView = UIImageView().then { 
    //UIImageView는 UIImage객체를 보유하기 위해 가짜 subView를 생성
    $0.layer.masksToBounds = true
  }
  let nameLabel = UILabel().then {
    $0.text = "Name"
    $0.textColor = .black
    $0.font = .systemFont(ofSize: 20, weight: .bold)
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
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = SearchViewModel(
      network: NetworkService(configuration: .default),
      selectedUser: nil
    )
    
    //layout
    setUpView()
    setUpConstraints()
    bind()
    embedSearchControl()
  }
  
  //viewDidLoad에서는 bound, frame 접근 불가능
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.width / 2
  }
  
  //MARK: - Combine
  private func bind() {
    viewModel.selectedUser
      .receive(on: RunLoop.main)
      .sink { [weak self] user in
        self?.nameLabel.text = self?.viewModel.name
        self?.loginLabel.text = self?.viewModel.login
        self?.followerLabel.text = self?.viewModel.followers
        self?.followingLabel.text = self?.viewModel.following
        self?.thumbnailImageView.kf.setImage(with: self?.viewModel.imageURL)
      }.store(in: &viewModel.subscriptions)
  }
  
  
  //MARK: - Setup
  private func embedSearchControl() {
    self.navigationItem.title = "Search"
    let searchController = UISearchController(searchResultsController: nil)
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.placeholder = "Input ID"

    searchController.searchBar.delegate = self //delegate
    
    self.navigationItem.searchController = searchController
  }
  
  //MARK: - Layout
  private func setUpView() {
    self.view.addSubview(thumbnailImageView)
    self.view.addSubview(nameLabel)
    self.view.addSubview(loginLabel)
    self.view.addSubview(followerLabel)
    self.view.addSubview(followingLabel)
  }
  
  private func setUpConstraints() {
    
    thumbnailImageView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(nameLabel.snp.top).offset(-30)
      $0.width.height.equalTo(160)
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
}

extension UserProfileViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let keyword = searchBar.text, !keyword.isEmpty else { return }
    viewModel.search(keyword: keyword)
  }
}
