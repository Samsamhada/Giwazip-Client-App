//
//  NetworkAPI.swift
//  GiwazipClient
//
//  Created by 김민택 on 2022/12/10.
//

import Foundation

struct NetworkAPI {
    private let apiService: Requestable

    init(apiService: Requestable) {
        self.apiService = apiService
    }
}
