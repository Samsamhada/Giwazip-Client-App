//
//  NetworkRequest.swift
//  GiwazipClient
//
//  Created by 김민택 on 2022/12/10.
//

import Foundation

struct NetworkRequest {
    let url: String
    let headers: [String: String]?
    let body: Data?
    let requestTimeOut: Float?
    let httpMethod: HTTPMethod

    init(url: String, headers: [String : String]? = nil, body: Data? = nil, requestTimeOut: Float? = nil, httpMethod: HTTPMethod) {
        self.url = url
        self.headers = headers
        self.body = body
        self.requestTimeOut = requestTimeOut
        self.httpMethod = httpMethod
    }

    func buildURLRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(APIEnvironment.apiKey, forHTTPHeaderField: "API-Key")
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        urlRequest.httpBody = body
        return urlRequest
    }
}
