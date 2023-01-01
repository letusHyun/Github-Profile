//
//  Publisher+Utils.swift
//  Github-Profile
//
//  Created by SeokHyun on 2023/01/01.
//

import Foundation
import Combine

extension Publisher {
  //Publisher는 프로토콜이므로, Publisher.fail(error)로 접근 불가능
  //Publisher를 채택하는 Fail.fail(error)로 접근해야 함
  static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
    
    //error에 해당하는 Fail 객체 생성후, AnyPublisher로 변환해서 반환
    //Fail 객체는 Failure를 제네릭으로 담고 있음(where Failure: Error)
    return Fail(error: error).eraseToAnyPublisher()
  }
}
  
