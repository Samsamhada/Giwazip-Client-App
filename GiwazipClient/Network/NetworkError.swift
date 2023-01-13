//
//  NetworkError.swift
//  GiwazipClient
//
//  Created by 김민택 on 2022/12/10.
//

import Foundation

enum NetworkError: Error {
    case encodingError
    case clientError(message: String?)
    case serverError
}
