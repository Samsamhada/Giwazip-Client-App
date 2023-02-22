//
//  NetworkResults.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/02/07.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case notFound
    case connectionFail
    case serverError
    case networkFail
}
