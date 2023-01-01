//
//  Resource.swift
//  Github-Profile
//
//  Created by SeokHyun on 2023/01/01.
//

import Foundation


//urlComponents와 urlRequest. 우리는 T를 Decodable할 것이므로 제네릭으로 명시해줌
struct Resource<T: Decodable> {
  var base: String
  var path: String
  var params: [String: String]
  var header: [String: String]
  
  var urlRequest: URLRequest? {
    var urlComponents = URLComponents(string: base + path)!
    let queryItems = params.map { (key: String, value: String) in
      URLQueryItem(name: key, value: value)
    }
    urlComponents.queryItems = queryItems
    
    var request = URLRequest(url: urlComponents.url!)
    header.forEach { (key: String, value: String) in
      request.addValue(value, forHTTPHeaderField: key)
    }
    
    return request
  }
  
  init(base: String, path: String, params: [String : String] = [:], header: [String : String] = [:]) {
    self.base = base
    self.path = path
    self.params = params
    self.header = header
  }
}
