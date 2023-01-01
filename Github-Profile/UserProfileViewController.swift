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
  let network = NetworkService(configuration: .default)
  
  @Published private(set) var user: UserProfile?
  var subscriptions = Set<AnyCancellable>()
  
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
    $user //user에 값 주입 받을 시 실행
      .receive(on: RunLoop.main)
      .sink { [weak self] user in
        self?.update(user)
      }.store(in: &subscriptions)
  }
  
  private func update(_ user: UserProfile?) {
    guard let user = user else {
      self.nameLabel.text = "n/a"
      self.loginLabel.text = "n/a"
      self.followerLabel.text = ""
      self.followingLabel.text = ""
      self.thumbnailImageView.image = nil
      return
    }
    
    self.nameLabel.text = user.name
    self.loginLabel.text = user.login
    self.followerLabel.text = "follower: \(user.followers)"
    self.followingLabel.text = "following: \(user.following)"
    self.thumbnailImageView.kf.setImage(with: user.avatarUrl)
    
  }
  
  //MARK: - Setup
  private func embedSearchControl() {
    self.navigationItem.title = "Search"
    let searchController = UISearchController(searchResultsController: nil)
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.placeholder = "Input ID"
    
    searchController.searchResultsUpdater = self //delegate
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

extension UserProfileViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
  }
}

extension UserProfileViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    print("button clicked: \(searchBar.text!)")
    
    guard let keyword = searchBar.text, !keyword.isEmpty else { return }
    
    //Resource
    let resource = Resource<UserProfile>(
      base: "https://api.github.com/",
      path: "users/\(keyword)",
      params: [:],
      header: ["Content-Type":"application/json"])
    
    //NetworkService
    
    network.load(resource)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .failure(let error):
          self.user = nil
        case .finished: break
        }
      } receiveValue: { user in
        self.user = user
      }
      .store(in: &subscriptions)
  }
}
