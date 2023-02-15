//
//  APIEnvironment.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/02/15.
//

import Foundation

enum APIEnvironment {
    static let baseURL = "https://api.samsamhada.app/giwazip"
    static let usersURL = "\(baseURL)/users"
    static let workersURL = "\(baseURL)/workers"
    static let roomsURL = "\(baseURL)/rooms"
    static let userroomsURL = "\(baseURL)/user-rooms"
    static let categoriesURL = "\(baseURL)/categories"
    static let postsURL = "\(baseURL)/posts"
    static let photosURL = "\(baseURL)/photos"
    static let headerKey = "x-api-key"
    static let apiKey = "tvlu5jsrJYSqVG3WLCIwFFZMyisfVZ6kr3bRrqptiWGGJauIjiHcECM4KSOSXYXX0j7mhvv3tdwYiqKxd1t9Nr0RfvOtaJuYaw50pHpynVpfoQjSiiPq5Xp06Hc63Myh"
}
