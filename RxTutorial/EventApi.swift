//
//  EventApi.swift
//  RxTutorial
//
//  Created by grzesiek on 21/11/2016.
//  Copyright © 2016 Mateusz Mirkowski. All rights reserved.
//

import Foundation
import Moya

enum EventApi {
  case eventsList
  case eventsDetails(id: Int)
}

extension EventApi: TargetType {
  var baseURL: URL { return URL(string: "https://api.com")! }
  var path: String {
    switch self {
    case .eventsList:
      return "/events"
    case .eventsDetails(let id):
      return "/event/\(id)"
    }
  }
  var method: Moya.Method {
    switch self {
    case .eventsList:
      return .get
    case .eventsDetails:
      return .post
    }
    
  }
  var parameters: [String : Any]? {
    switch self {
    case .eventsList:
      return nil
    case .eventsDetails(let id):
      return ["id": id]
    }
  }
  var sampleData: Data {
    switch self {
    case .eventsList:
      return "Test event data".utf8EncodedData
    case .eventsDetails(let id):
      return "{\"id\": \(id), \"name\": \"Super Event\", \"description\": \"Go go go!\"}".utf8EncodedData
    }
  }
  var task: Task {
    switch self {
    case .eventsList, .eventsDetails:
      return .request
    }
  }
}

// MARK: - Helpers
private extension String {
  var urlEscapedString: String {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
  
  var utf8EncodedData: Data {
    return self.data(using: .utf8)!
  }
}
