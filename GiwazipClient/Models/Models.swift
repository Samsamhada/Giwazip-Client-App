//
//  User.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/02/06.
//

import Foundation

// MARK: - User

struct User: Codable {
    let userID: Int?
    let number: String
    let worker: Worker?
    let userrooms: [UserRoom]?
}

// MARK: - Worker

struct Worker: Codable {
    let userIdentifier: String
    let name: String
    let email: String
}

// MARK: - UserRoom

struct UserRoom: Codable {
    let userID: Int?
    let roomID: Int?
    let user: User?
    let room: Room?
}

// MARK: - Room

struct Room: Codable {
    let roomID: Int?
    let name: String
    let startDate: String
    let endDate: String
    let warrantyTime: Int
    let inviteCode: String
    let userrooms: [UserRoom]?
    let posts: [Post]?
    let categories: [Category]?
}

// MARK: - Post

struct Post: Codable {
    let postID: Int
    let userID: Int
    let categoryID: Int?
    let description: String
    let createDate: String
    let category: Category?
    let photos: [Photo]
    let user: User?
}

// MARK: - Category

struct Category: Codable {
    let categoryID: Int
    let name: String
    let progress: Int?
}

// MARK: - Photo

struct Photo: Codable {
    let photoID: Int
    let url: String
}

struct Admin: Codable, Hashable {
    var adminID: Int?
    let name: String
}

struct Notice: Codable, Hashable {
    let noticeID: Int
    var adminID: Int?
    let title: String
    let content: String
    let createDate: String
    let isHidden: Bool
    var admin: Admin?
}
