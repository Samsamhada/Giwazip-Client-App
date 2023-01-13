//
//  RoomDTO.swift
//  GiwazipClient
//
//  Created by 김민택 on 2022/12/10.
//

import Foundation

struct RoomDTO: Encodable {
    var clientNumber: String

    init(clientNumber: String) {
        self.clientNumber = clientNumber
    }
}
