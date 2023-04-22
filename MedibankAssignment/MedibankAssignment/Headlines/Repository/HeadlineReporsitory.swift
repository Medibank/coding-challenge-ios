//
//  HeadlineReporsitory.swift
//  MedibankAssignment
//
//  Created by Rohit  on 12/2/2023.
//

import Foundation
import RxSwift

enum HeadlineRepositoryConstant {
    static let url = "https://newsapi.org/v2/top-headlines?sources=%@&apiKey=349f23b94c2649409401144183140fc0"
}

protocol HeadlineURL {
    func makeURL()-> URL?
}

struct HeadlineRepositoryURLManager: HeadlineURL {
    private let sharedState: SharedState
    
    init(sharedState: SharedState = Singleton.shared) {
        self.sharedState = sharedState
    }
    
    func makeURL()-> URL? {
        let urlString = String(format: HeadlineRepositoryConstant.url, sharedState.getCommaSeparatedSources())
        return URL(string: urlString)
    }
}

protocol HeadlineRepository {
    func fetchHeadlines<T: Codable>(type: T.Type) -> Observable<Result<T, Error>>
}

struct HeadlineViewRepository: HeadlineRepository {
    private let manager: DownloadManager
    private let urlManager: HeadlineRepositoryURLManager = HeadlineRepositoryURLManager()
    
    init(manager: DownloadManager) {
        self.manager = manager
    }
    
    func fetchHeadlines<T: Codable>(type: T.Type) -> Observable<Result<T, Error>> {
        guard let url = urlManager.makeURL() else { return Observable<Result<T, Error>>.just(.failure(MedibankNetworkError.badURL)) }
        return manager.makeGetApiCall(url: url, type: type)
    }
}
