//
//  NetworkManager.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/02/07.
//

import Foundation

import Alamofire
import RxSwift
import RxCocoa

class NetworkManager {
    static let shared = NetworkManager()
    let header: HTTPHeaders = [APIEnvironment.apiField: APIEnvironment.apiKey]
    var userData: User?
    var roomData: Room?
    
    init() {
        // TODO: 그때그때 방 번호가 달라져야 함!
        loadUserData(url: APIEnvironment.usersURL + "/1")
        loadUserData(url: APIEnvironment.usersURL + "/room/1")
        
        loadRoomData(url: APIEnvironment.roomsURL + "/1")
        loadRoomData(url: APIEnvironment.roomsURL + "/category/1")
        loadRoomData(url: APIEnvironment.roomsURL + "/post/1")
        loadRoomData(url: APIEnvironment.roomsURL + "/post-category/1")
        loadRoomData(url: APIEnvironment.roomsURL + "/user/1")
    }

    func requestUserData(url: String) -> Observable<NetworkResult<Any>> {
        return Observable.create() { observer in
            AF.request(url,
                       method: .get,
                       encoding: JSONEncoding.default,
                       headers: self.header).responseData { (response) in
                switch response.result {
                case .success:
                    guard let data = response.data,
                          let statusCode = response.response?.statusCode
                    else { return }
                    let networkResult = self.judgeStatus(by: statusCode,
                                                         self.isValidUserData(data: data))
                    observer.onNext(networkResult)
                    observer.onCompleted()
                case .failure: break }
            }
            return Disposables.create()
        }
    }
    
    func requestRoomData(url: String) -> Observable<NetworkResult<Any>> {
        return Observable.create() { observer in
            AF.request(url,
                       method: .get,
                       encoding: JSONEncoding.default,
                       headers: self.header).responseData { (response) in
                switch response.result {
                case .success:
                    guard let data = response.data,
                          let statusCode = response.response?.statusCode
                    else { return }
                    let networkResult = self.judgeStatus(by: statusCode,
                                                         self.isValidRoomData(data: data))
                    observer.onNext(networkResult)
                    observer.onCompleted()
                case .failure: break }
            }
            return Disposables.create()
        }
    }
    
    func loadUserData(url: String) {
        _ = requestUserData(url: url)
            .subscribe { status in
                switch status {
                case .success(let userData):
                    guard let userData = userData as? User else { return }
                    self.userData = userData
                case .reqError(let msg):
                    print("This is requestError:", msg)
                case .pathError:
                    print("This is pathError")
                case .serverError:
                    print("This is serverError")
                case .networkFail:
                    print("This is networkFail")
                }
            }
    }
    
    func loadRoomData(url: String) {
        _ = requestRoomData(url: url)
            .subscribe { status in
                switch status {
                case .success(let roomData):
                    guard let roomData = roomData as? Room else { return }
                    self.roomData = roomData
                case .reqError(let msg):
                    print("This is requestError:", msg)
                case .pathError:
                    print("This is pathError")
                case .serverError:
                    print("This is serverError")
                case .networkFail:
                    print("This is networkFail")
                }
            }
    }

    func judgeStatus(by statusCode: Int, _ networkResult: NetworkResult<Any>) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return networkResult
        case 404: return .pathError
        case 500: return .serverError
        default: return .networkFail
        }
    }

    func isValidUserData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let userData = try? decoder.decode(User.self, from: data)
        else { return .pathError }
        return .success(userData)
    }
    
    func isValidRoomData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let roomData = try? decoder.decode(Room.self, from: data) else { return .pathError }
        return .success(roomData)
    }
}
