//
//  DownloadManager.swift
//  MedibankAssignment
//
//  Created by Rohit  on 10/2/2023.
//

import Foundation
import RxAlamofire
import RxSwift

enum MedibankNetworkError: Error {
    case badURL
    case invalidResponse
    case badMapping
}

protocol DownloadManager {
    func makeGetApiCall<T: Codable>(url: URL, type: T.Type)-> Observable<Result<T, Error>>
}

struct MedibankDownloadManager: DownloadManager {
    func makeGetApiCall<T: Codable>(url: URL, type: T.Type)-> Observable<Result<T, Error>> {
        RxAlamofire.request(.get, url).responseData().map { (response, data) in
            if response.statusCode != 200 {
                return .failure(MedibankNetworkError.invalidResponse)
            } else {
                let decoder = JSONDecoder()
                do {
                    return .success(try decoder.decode(type, from: data))
                } catch {
                    return .failure(MedibankNetworkError.badMapping)
                }
            }
        }
    }
}
