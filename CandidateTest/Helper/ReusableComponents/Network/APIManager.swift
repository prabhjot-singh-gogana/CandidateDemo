//
//  Network.swift
//  ArticleDemo
//
//  Created by Prabhjot Singh Gogana on 14/7/22.
//


import Foundation
import Alamofire
import RxRelay
import RxSwift

enum URLEnum {
    case list
    
    var value: String {
        switch self {
        case .list:
            return "/contentList.json"
        }
    }
}

final class APIManager<T: PSJsonDecoding> {
    enum Method: String {
        case POST = "POST"
        case GET = "GET"
    }
    private var request: PSJsonRequest!
    private var fromKey: String?
    var failureError = BehaviorRelay<AFError?>.init(value: nil)
    
    private init(builder: PSJsonRequest) {
        self.request = builder
    }
    static func request(_ urlEnum: URLEnum, header: [String: String]? = nil, param: [String: String]? = nil, method: Method = .GET) -> APIManager<T> {
        let url = PSconfiguration.shared.baseURL + urlEnum.value
        let builder = PSJsonRequest(url: url,
                       method: ((method == Method.GET) ? .get: .post),
                       params: param);
        return APIManager<T>.init(builder: builder)
    }
    func add(param params: Codable) -> APIManager<T> {
        self.request.parameters = (self.request.parameters == nil) ? (params.toJSON() ?? [:])  : self.request?.parameters?.merging(params.toJSON() ?? [:]) {$1}
        return self
    }
    func add(param params: [String: Any]) -> APIManager<T> {
        let nonNillable = params.filter { !($0.1 is NSNull) }
        self.request.parameters = (self.request.parameters == nil) ? nonNillable : self.request?.parameters?.merging(nonNillable) {$1}
        return self
    }
    func add(_ params: [String: Any]) {
        let nonNillable = params.filter { !($0.1 is NSNull) }
        self.request.parameters = (self.request.parameters == nil) ? nonNillable : self.request?.parameters?.merging(nonNillable) {$1}
    }
    func add(header headers: [String: String]) -> APIManager<T> {
        self.request.headers = Alamofire.HTTPHeaders(headers)
        return self
    }
    func add(method methods: Method) -> APIManager<T> {
        self.request.method = (methods == Method.GET) ? .get: .post
        return self
    }
    func addKey(fromResponseJson key: String) -> APIManager<T> {
        self.fromKey = key
        return self
    }

    var response: Observable<T?> {
        return self.request.jsonResponse()
            .filter({ res  in
                switch res.result {
                case .success(_):
                    return true
                case .failure(let error):
                    self.failureError.accept(error)
                    return false
                }
            })
            .map({ (result) -> T? in
                guard let jsonResponse = result.value as? [String: AnyObject] else {
                    self.failureError.accept(AFError.responseSerializationFailed(reason: .customSerializationFailed(error: PSError.jsonDataIsNotDictionary)))
                    return nil
                }
                guard let nsiResponse = T.decode(dict: jsonResponse, from: self.fromKey) else {
                    self.failureError.accept(AFError.responseSerializationFailed(reason: .decodingFailed(error: PSError.dictionaryIsNotDecodable)))
                    return nil
                }
                return nsiResponse as? T
            })
    }
    var responseArray: Observable<[T]?> {
        return self.request.jsonResponse()
            .filter({ res  in
                switch res.result {
                case .success(_):
                    return true
                case .failure(let error):
                    self.failureError.accept(error)
                    return false
                }
            })
            .map({ (result) -> [T]? in
                guard let jsonResponse = result.value as? [String: AnyObject] else {
                    self.failureError.accept(AFError.responseSerializationFailed(reason: .customSerializationFailed(error: PSError.jsonDataIsNotDictionary)))
                    return nil
                }
                guard let nsiResponse = T.arrayDecoding(dict: jsonResponse, from: self.fromKey) else {
                    self.failureError.accept(AFError.responseSerializationFailed(reason: .decodingFailed(error: PSError.dictionaryIsNotDecodable)))
                    return nil
                }
                return nsiResponse as? [T]
            })
    }
}
private enum PSError: Error {
    case jsonDataIsNotDictionary
    case dictionaryIsNotDecodable
}
