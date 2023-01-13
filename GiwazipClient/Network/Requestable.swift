//
//  Requestable.swift
//  GiwazipClient
//
//  Created by 김민택 on 2022/12/10.
//

import Foundation

protocol Requestable {
    var requestTimeOut: Float { get }

    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T?
}
