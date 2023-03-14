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
    var noticeDatas: [Notice] = []

    private init() {
        // TODO: 그때그때 방 번호가 달라져야 함!
        loadOrCreateData(url: APIEnvironment.usersURL + "/room/1", type: User.self) { data in
            self.userData = data
        }
        loadOrCreateData(url: APIEnvironment.roomsURL + "/category-post/1", type: Room.self) { data in
            self.roomData = data
        }
        loadOrCreateData(url: APIEnvironment.noticesURL, type: [Notice].self) { noticeDatas in
            self.noticeDatas = noticeDatas
        }
    }

    func loadOrCreateData<T: Decodable>(url: String,
                                        httpMethod: HTTPMethod = .get,
                                        parameters: Parameters? = nil,
                                        type: T.Type,
                                        completion: @escaping (T) -> Void) {
        let responseData = requestData(url: url,
                                       httpMethod: httpMethod,
                                       parameters: parameters,
                                       type: type)
        checkStatus(responseData) { data in
            completion(data)
        }
    }

    func uploadPostData(description: String, files: [Data]) {
        let responseData = requestUploadData(userID: 3,
                                             roomID: 1,
                                             categoryID: 1,
                                             description: description,
                                             files: files,
                                             url: APIEnvironment.postsURL + "/photo",
                                             type: Post.self)
        checkStatus(responseData) { data in
            self.roomData = data
        }
    }

    private func checkStatus<T>(_ responseData: Observable<NetworkResult<Any>>,
                                completion: @escaping (T) -> Void) {
        responseData.bind { status in
            switch status {
            case .success(let data):
                guard let data = data as? T else { return }
                completion(data)
            case .badRequest(let badRequest):
                print("This is: \(badRequest)")
            case .connectionFail(let connectionFail):
                print("This is: \(connectionFail)")
            case .notFound(let notFound):
                print("This is: \(notFound)")
            case .serverError(let serverError):
                print("This is: \(serverError)")
            case .decodingError:
                print("디코딩 에러가 발생했습니다. 디코딩 하려는 모델과, API 명세를 다시 확인해주세요.")
            default:
                print("This is NetworkError, so Check your Cellular data Or Wifi")
            }
        }
    }

    // MARK: - Network Request

    private func requestData<T: Decodable>(url: String,
                                           httpMethod: HTTPMethod,
                                           parameters: Parameters? = nil,
                                           type: T.Type) -> Observable<NetworkResult<Any>> {
        return Observable.create() { observer in
            let dataRequest = AF.request(url,
                                         method: httpMethod,
                                         parameters: parameters,
                                         encoding: JSONEncoding.default,
                                         headers: self.header)
            self.checkResponseData(request: dataRequest, type: type, observer: observer)
            return Disposables.create()
        }
    }

    private func requestUploadData<T: Decodable> (userID: Int,
                                                  roomID: Int,
                                                  categoryID: Int,
                                                  description: String,
                                                  files: [Data],
                                                  url: String,
                                                  httpMethod: HTTPMethod = .post,
                                                  type: T.Type) -> Observable<NetworkResult<Any>> {
        return Observable.create() { observer in
            let header: HTTPHeaders = ["Content-Type": "multipart/form-data",
                                       APIEnvironment.apiField: APIEnvironment.apiKey]
            let parameters: [String: Any] = ["userID": userID,
                                             "roomID": roomID,
                                             "categoryID": categoryID,
                                             "description": description,
                                             "files": files]

            let dataUpload = AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }

                for i in 0..<files.count {
                    let photo = files[i]
                    multipartFormData.append(photo,
                                             withName: "files",
                                             fileName: "\(userID)0\(i + 1).jpeg")
                }
            }, to: url, usingThreshold: UInt64.init(), method: httpMethod, headers: header)

            self.checkResponseData(request: dataUpload, type: type, observer: observer)
            return Disposables.create()
        }
    }

    // MARK: - Network Response

    private func checkResponseData<T: Decodable>(request: DataRequest,
                                                 type: T.Type,
                                                 observer: AnyObserver<NetworkResult<Any>>) {
        request.responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data,
                      let statusCode = response.response?.statusCode
                else { return }

                let networkResult = self.isValidData(data: data, type: T.self, by: statusCode)
                observer.onNext(networkResult)
                observer.onCompleted()
            case .failure:
                break
            }
        }
    }

    // MARK: - Check Server Data

    private func isValidData<T: Decodable>(data: Data,
                                           type: T.Type,
                                           by statusCode: Int) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let data = try? decoder.decode(type, from: data)
        else { return .decodingError }

        switch statusCode {
        case 200: return .success(data)
        case 400: return .badRequest(data)
        case 403: return .connectionFail(data)
        case 404: return .notFound(data)
        case 500: return .serverError(data)
        default: return .networkFail
        }
    }
}
