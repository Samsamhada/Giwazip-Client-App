//
//  EndPointable.swift
//  GiwazipClient
//
//  Created by 김민택 on 2022/12/10.
//

import Foundation

protocol EndPointable {
    var requestTimeOut: Float { get }
    var httpMethod: HTTPMethod { get }
    var requestBody: Data? { get }
    func getURL(baseURL: String) -> String
}
