//
//  APIEnvironment.swift
//  GiwazipClient
//
//  Created by 김민택 on 2022/12/10.
//

import Foundation

enum APIEnvironment {
    static let baseURL: String = "https://api.samsamhada.app/giwazip"
    static let workersURL: String = "\(baseURL)/workers"
    static let roomsURL: String = "\(baseURL)/rooms"
    static let statusesURL: String = "\(baseURL)/statuses"
    static let postsURL: String = "\(baseURL)/posts"
    static let photosURL: String = "\(baseURL)/photos"
    static let apiKey: String = "pLqCZ9c4beicTErZzyQxvnPM1Fgp41O6mbyXzNHVCypyTNOoNgqCtWN4qXuZQDLuOSiI2a7y7nhu97JViwqWqunTW2oHfZoGY2OI"
}
