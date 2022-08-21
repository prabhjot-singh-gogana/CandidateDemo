//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift


struct PSJsonRequest {
    
    private var urlString: URLConvertible
    private var encoding: ParameterEncoding
    var method: Alamofire.HTTPMethod
    var parameters: [String: Any]?
    var headers: HTTPHeaders?
    var shouldShowLoader: Bool
    var shouldDisableInteraction: Bool
    private let bag = DisposeBag()
    
    init(url: URLConvertible, method: Alamofire.HTTPMethod = .get, params: [String: Any]? = nil, headers: [String: String]? = nil) {
        urlString = url
        self.method = method
        parameters = params
        self.encoding = (method == .post) ? Alamofire.JSONEncoding.default: URLEncoding.default
        self.headers = HTTPHeaders(headers ?? [:])
        shouldShowLoader = true
        shouldDisableInteraction = true
    }
    
    func jsonResponse() -> Observable<DataResponse<Any, AFError>> {
        return AF.request(self.urlString, method: self.method, parameters: self.parameters, encoding: self.encoding, headers: self.headers)
                .rx.responseJSON()
    }
}
