//
//  Encodable.swift
//  GiwazipClient
//
//  Created by 김민택 on 2022/12/10.
//

import Foundation

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
