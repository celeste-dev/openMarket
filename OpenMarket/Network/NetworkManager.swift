//
//  NetworkManager.swift
//  OpenMarket
//
//  Created by Erika Russi on 2024-01-18.
//

import Foundation
import Alamofire

actor NetworkManager: GlobalActor {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    let baseURL: String = "https://api.mercadolibre.com/"
    
    private let maxWaitTime = 30.0
    
    func get(path: String, parameters: Parameters?) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                baseURL + path,
                method: .get,
                parameters: parameters,
                requestModifier: { $0.timeoutInterval = self.maxWaitTime }
            )
            .cURLDescription { description in
                debugPrint(description)
            }
            .responseData { response in
                switch(response.result) {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }
    
    private func handleError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost
            {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                let currentError = NSError(
                    domain: nserror.domain,
                    code: code,
                    userInfo: userInfo
                )
                return currentError
            }
        }
        return error
    }
}
