//
//  NetworkManager.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/02/07.
//

import Foundation

import Alamofire
import RxCocoa
import RxSwift

final class NetworkManager {
    static let shared = NetworkManager()
    private let header: HTTPHeaders = [APIEnvironment.apiField: APIEnvironment.apiKey]
    var userData: User?
    var roomData: Room?
    var postData: Post?

    private init() {
        // TODO: 그때그때 방 번호가 달라져야 함!
//        loadUserData(url: APIEnvironment.usersURL + "/1")
        loadUserData(url: APIEnvironment.usersURL + "/room/1")
        
        loadRoomData(url: APIEnvironment.roomsURL + "/1")
//        loadRoomData(url: APIEnvironment.roomsURL + "/category/1")
//        loadRoomData(url: APIEnvironment.roomsURL + "/post/1")
//        loadRoomData(url: APIEnvironment.roomsURL + "/post-category/1")
//        loadRoomData(url: APIEnvironment.roomsURL + "/user/1")
    }

    // MARK: - Get
    
    func loadUserData(url: String) {
        let requestedData = requestData(url: url, type: User.self)
        checkUserStatus(requestData: requestedData)
    }

    func loadRoomData(url: String) {
        let requestedData = requestData(url: url, type: Room.self)
        checkRoomStatus(requestData: requestedData)
    }
    
    // MARK: - Post
    
    func createUserData(number: String) {
        let requestedData = requestData(url: APIEnvironment.usersURL,
                        httpMethod: .post,
                        parameters: makeParameter(number: number),
                        type: User.self)
        checkUserStatus(requestData: requestedData)
    }
    
    func uploadPostData(description: String, files: [Data]) {
        let requestedUploadPost = requestUploadPost(userID: 3, roomID: 1,
                              categoryID: 1, description: description,
                              files: files, url: APIEnvironment.postsURL + "/photo",
                              type: Post.self)
        checkPostStatus(requestData: requestedUploadPost)
    }

    // MARK: - Put

    func updateUserData(number: String) {
        let requestedData = requestData(url: APIEnvironment.usersURL + "/2",
                        httpMethod: .put,
                        parameters: makeParameter(number: number),
                        type: User.self)
        checkUserStatus(requestData: requestedData)
    }

    // MARK: - Network Request

    private func makeParameter(number: String) -> Parameters {
        return ["number": number]
    }
    
    private func requestData<T: Decodable>(url: String,
                                           httpMethod: HTTPMethod = .get,
                                           parameters: Parameters? = nil,
                                           type: T.Type) -> Observable<NetworkResult<Any>> {
        return Observable.create() { observer in
            let dataRequest = AF.request(url,
                                         method: httpMethod,
                                         parameters: parameters,
                                         encoding: JSONEncoding.default,
                                         headers: self.header)
            
            dataRequest.responseData { (response) in
                switch response.result {
                case .success:
                    guard let data = response.data,
                          let statusCode = response.response?.statusCode
                    else { return }
                    
                    let networkResult = self.judgeStatus(by: statusCode,
                                                         self.isValidData(data: data, type: T.self))
                    observer.onNext(networkResult)
                    observer.onCompleted()
                case .failure:
                    break
                }
            }
            return Disposables.create()
        }
    }
    
    // TODO: - bind closure 안에서 inout 등 사용법 찾으면 한 함수로 수정(checkStatus)
    func checkUserStatus(requestData: Observable<NetworkResult<Any>>){
        requestData.bind { status in
            switch status {
            case .success(let data):
                guard let data = data as? User else { return }
                self.userData = data
            case .badRequest:
                print(TextLiteral.badRequest)
            case .connectionFail:
                print(TextLiteral.connectionFail)
            case .notFound:
                print(TextLiteral.notFound)
            case .serverError:
                print(TextLiteral.serverError)
            case .networkFail:
                print(TextLiteral.networkFail)
            }
        }
    }
    
    func checkRoomStatus(requestData: Observable<NetworkResult<Any>>) {
        requestData.bind { status in
            switch status {
            case .success(let data):
                guard let data = data as? Room else { return }
                self.roomData = data
            case .badRequest:
                print(TextLiteral.badRequest)
            case .connectionFail:
                print(TextLiteral.connectionFail)
            case .notFound:
                print(TextLiteral.notFound)
            case .serverError:
                print(TextLiteral.serverError)
            case .networkFail:
                print(TextLiteral.networkFail)
            }
        }
    }
    
    func checkPostStatus(requestData: Observable<NetworkResult<Any>>) {
        requestData.bind { status in
            switch status {
            case .success(let data):
                guard let data = data as? Post else { return }
                self.postData = data
            case .badRequest:
                print(TextLiteral.badRequest)
            case .connectionFail:
                print(TextLiteral.connectionFail)
            case .notFound:
                print(TextLiteral.notFound)
            case .serverError:
                print(TextLiteral.serverError)
            case .networkFail:
                print(TextLiteral.networkFail)
            }
        }
    }

    private func judgeStatus(by statusCode: Int, _ networkResult: NetworkResult<Any>) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return networkResult
        case 403: return .connectionFail
        case 404: return .notFound
        case 500: return .serverError
        default: return .networkFail
        }
    }

    private func isValidData<T: Decodable>(data: Data, type: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let data = try? decoder.decode(type, from: data)
        else { return .notFound }
        return .success(data)
    }
}
