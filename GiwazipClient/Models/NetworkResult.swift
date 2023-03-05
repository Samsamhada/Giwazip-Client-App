//
//  NetworkResults.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/02/07.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case badRequest(T)
    case notFound(T)
    case connectionFail(T)
    case serverError(T)
    case networkFail
    case decodingError
}
