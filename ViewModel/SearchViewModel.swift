//
//  SearchViewModel.swift
//  Github-Profile
//
//  Created by SeokHyun on 2023/01/04.
//

import Foundation
import Combine

final class SearchViewModel {
  
  let network: NetworkService
  var subscriptions = Set<AnyCancellable>()
  
  init(network: NetworkService, selectedUser: UserProfile?) {
    self.network = network
    self.selectedUser = CurrentValueSubject(selectedUser)
  }
  
  //Output: Data
  let selectedUser: CurrentValueSubject<UserProfile?, Never>
  var name: String {
    selectedUser.value?.name ?? "n/a"
  }
  var login: String {
    selectedUser.value?.login ?? "n/a"
  }
  var followers: String {
    guard let value = selectedUser.value?.followers else { return "" }
    return "followers: \(value)"
  }
  var following: String {
    guard let value = selectedUser.value?.following else { return "" }
    return "followers: \(value)"
  }
  var imageURL: URL? {
    return selectedUser.value?.avatarUrl
  }
  
  //Input: User Action
  func search(keyword: String) {
    
    //Resource
    let resource = Resource<UserProfile>(
      base: "https://api.github.com/",
      path: "users/\(keyword)",
      params: [:],
      header: ["Content-Type":"application/json"])
    
    //NetworkService
    self.network.load(resource)
      .receive(on: RunLoop.main)
      .sink { [weak self] completion in
        switch completion {
        case .failure(let error):
          print("error: \(error.localizedDescription)")
          self?.selectedUser.send(nil)
        case .finished: break
        }
      } receiveValue: { [weak self] user in
        self?.selectedUser.send(user)
      }
      .store(in: &subscriptions)
  }
}
