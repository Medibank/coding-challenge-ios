//
//  SourceRepository.swift
//  MedibankAssignment
//
//  Created by Rohit  on 10/2/2023.
//

import Foundation
import RxSwift

enum SourceViewRepositoryConstant {
    static let url = "https://newsapi.org/v2/top-headlines/sources?apiKey=349f23b94c2649409401144183140fc0"
}

protocol SourceURL {
    func makeURL()-> URL?
}

struct SourceRepositoryURLManager: SourceURL {
    func makeURL()-> URL? {
        return URL(string: SourceViewRepositoryConstant.url)
    }
}

protocol SourceRepository {
    func fetchSources<T: Codable>(type: T.Type) -> Observable<Result<T, Error>>
}

struct SourceViewRepository: SourceRepository {
    private let manager: DownloadManager
    private let urlManager: SourceURL = SourceRepositoryURLManager()
    
    init(manager: DownloadManager) {
        self.manager = manager
    }
    
    func fetchSources<T: Codable>(type: T.Type) -> Observable<Result<T, Error>> {
        guard let url = urlManager.makeURL() else { return Observable<Result<T, Error>>.just(.failure(MedibankNetworkError.badURL)) }
        return manager.makeGetApiCall(url: url, type: type)
    }
}
