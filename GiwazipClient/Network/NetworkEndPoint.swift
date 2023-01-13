//
//  NetworkEndPoint.swift
//  GiwazipClient
//
//  Created by 김민택 on 2022/12/10.
//

import Foundation

enum NetworkEndPoint: EndPointable {
    case loadRoom(roomID: Int)
    case loadRoomByInviteCode(inviteCode: String)
    case updateClientNumber(inviteCode: String, body: RoomDTO)

    var requestTimeOut: Float {
        return 10
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .loadRoom, .loadRoomByInviteCode:
            return .get
        case .updateClientNumber:
            return .put
        }
    }

    var requestBody: Data? {
        switch self {
        case .updateClientNumber(_, let body):
            return body.encode()
        default:
            return nil
        }
    }

    func getURL(baseURL: String) -> String {
        switch self {
        case .loadRoom(let roomID):
            return "\(APIEnvironment.roomsURL)/\(roomID)"
        case .loadRoomByInviteCode(let inviteCode), .updateClientNumber(let inviteCode, _):
            return "\(APIEnvironment.roomsURL)/invite_code/\(inviteCode)"
        }
    }

    func createRequest() -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        return NetworkRequest(url: getURL(baseURL: APIEnvironment.baseURL),
                              headers: headers,
                              body: requestBody,
                              requestTimeOut: requestTimeOut,
                              httpMethod: httpMethod
        )
    }
}
