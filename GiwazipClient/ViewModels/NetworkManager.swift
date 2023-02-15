//
//  NetworkManager.swift
//  GiwazipClient
//
//  Created by 지준용 on 2023/02/07.
//

import Foundation

import Alamofire
import RxSwift

class NetworkManager {
    static let shared = NetworkManager()
    let header: HTTPHeaders = [APIEnvironment.headerKey: APIEnvironment.apiKey]
    var userData: User?

    init() {
        // TODO: 그때그때 방 번호가 달라져야 함!
        _ = loadUserData(url: APIEnvironment.usersURL + "/room/1").subscribe { status in
            switch status {
            case .success(let userData):
                guard let data = userData as? User else { return }
                self.userData = data
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

    func loadUserData(url: String) -> Observable<NetworkResult<Any>> {
        return Observable.create() { observer in
            AF.request(url,
                       method: .get,
                       encoding: JSONEncoding.default,
                       headers: self.header).responseData { (response) in
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    guard let statusCode = response.response?.statusCode else { return }
                    let networkResult = self.judgeStatus(by: statusCode, data)
                    observer.onNext(networkResult)
                    observer.onCompleted()
                case .failure:
                    break
                }
            }
            return Disposables.create()
        }
    }

    func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isValidData(data: data)
        case 400: return .pathError
        case 500: return .serverError
        default: return .networkFail
        }
    }

    func isValidData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let userData = try? decoder.decode(User.self, from: data) else { return .pathError }
        return .success(userData)
    }
}
