//
//  NetworkAPI.swift
//  OpenMarket
//
//  Created by Erika Russi on 2024-01-18.
//

import Foundation
import Alamofire

class NetworkAPI {
    
    static func getProducts(countryKey: String, productToSearch: String) async -> ProductResearchResponse? {
        let parameters: Parameters = [
            "q": productToSearch
        ]
        do {
            let findProductPath: String = "sites/" + countryKey + "/search"
            let data = try await NetworkManager.shared.get(
                path: findProductPath, parameters: parameters
            )
            let result: ProductResearchResponse? = try self.parseData(data: data)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private static func parseData<T: Decodable>(data: Data) throws -> T? {
        if !data.isEmpty {
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch let error {
                print(error.localizedDescription)
                
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .dataCorrupted(let context):
                        print("Data corrupted: \(context)")
                    case .keyNotFound(let key, let context):
                        print("Key '\(key)' not found: \(context)")
                    case .typeMismatch(let type, let context):
                        print("Type mismatch: '\(type)' \(context)")
                    case .valueNotFound(let type, let context):
                        print("Value not found for type '\(type)': \(context)")
                    @unknown default:
                        print("An unknown decoding error occurred")
                    }
                } else {
                    print("Error not identified")
                }
                throw NSError(
                    domain: "NetworkAPIError",
                    code: 3,
                    userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
                )
            }
        } else {
            print("Empty data")
            return nil
        }
    }
}
