//
//  UserProfile.swift
//  Github-Profile
//
//  Created by SeokHyun on 2022/12/30.
//

import Foundation

struct UserProfile: Hashable, Identifiable, Decodable {
  
  var id: Int64
  var login: String
  var name: String
  var avatarUrl: URL
  var htmlUrl: String
  var followers: Int
  var following: Int
  
  enum CodingKeys: String, CodingKey {
    case id
    case login
    case name
    case avatarUrl = "avatar_url"
    case htmlUrl = "html_url"
    case followers
    case following
  }
}
