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
    let header: HTTPHeaders = [APIEnvironment.apiField: APIEnvironment.apiKey]
    var userData: User?
    var roomData: Room?

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

    // MARK: - Load Data
    
    func loadUserData(url: String) {
        _ = requestData(url: url, type: User.self)
            .subscribe { status in
                switch status {
                case .success(let userData):
                    guard let userData = userData as? User else { return }
                    self.userData = userData
                case .connectionFail:
                    print("This is connectionFail")
                case .reqError:
                    print("This is requestError")
                case .serverError:
                    print("This is serverError")
                case .networkFail:
                    print("This is networkFail")
                }
            }
    }

    func loadRoomData(url: String) {
        _ = requestData(url: url, type: Room.self)
            .subscribe { status in
                switch status {
                case .success(let roomData):
                    guard let roomData = roomData as? Room else { return }
                    self.roomData = roomData
                case .connectionFail:
                    print("This is connectionFail")
                case .reqError:
                    print("This is requestError")
                case .serverError:
                    print("This is serverError")
                case .networkFail:
                    print("This is networkFail")
                }
            }
    }

    // MARK: - Network Request

    func requestData<T: Decodable>(url: String, type: T.Type) -> Observable<NetworkResult<Any>> {
        return Observable.create() { observer in
            AF.request(url,
                       method: .get,
                       encoding: JSONEncoding.default,
                       headers: self.header)
              .responseData { (response) in
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

    func judgeStatus(by statusCode: Int, _ networkResult: NetworkResult<Any>) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return networkResult
        case 403: return .connectionFail
        case 404: return .reqError
        case 500: return .serverError
        default: return .networkFail
        }
    }

    func isValidData<T: Decodable>(data: Data, type: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let data = try? decoder.decode(type, from: data)
        else { return .reqError }
        return .success(data)
    }
}
