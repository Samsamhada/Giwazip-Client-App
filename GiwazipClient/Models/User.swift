//
//  User.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/02/06.
//

import Foundation

// MARK: - User

struct User: Codable {
    let userID: Int
    let number: String
    let worker: Worker
    let userrooms: [UserRoom]
}

// MARK: - Worker

struct Worker: Codable {
    let userIdentifier: String
    let name: String
    let email: String
}

// MARK: - Userroom

struct UserRoom: Codable {
    let roomID: Int
    let room: Room
}

// MARK: - Room

struct Room: Codable {
    let name: String
    let startDate: String
    let endDate: String
    let warrantyTime: Int
    let inviteCode: String
}
