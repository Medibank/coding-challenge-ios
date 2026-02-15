//
//  NewsReaderAPIServiceRequest.swift
//

import Foundation

final class NewsReaderAPIServiceRequest {
    private let apiKey = "6328308dbece476db477f50b97c7765f"
    private let baseURL = "https://newsapi.org/v2"
    
    enum APIError: Error {
        case invalidURL
        case invalidResponse
        case decodingError
    }
    
    // MARK: Fetch data from newsAPI
    func fetchNews() async throws -> [NewArticles] {

         guard let url = URL(string: "\(baseURL)/top-headlines?country=us&apiKey=\(apiKey)") else {
             throw APIError.invalidURL
         }

         let (data, response) = try await URLSession.shared.data(from: url)

         guard let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 else {
             throw APIError.invalidResponse
         }

         do {
             let decoded = try JSONDecoder().decode(NewsResponse.self, from: data)
             return decoded.articles
         } catch {
             throw APIError.decodingError
         }
     }
    
    // MARK: Fetch mock data
    func fetchMockNews() throws -> [NewArticles] {

        guard let url = Bundle.main.url(forResource: "mockarticles", withExtension: "json") else {
            throw APIError.invalidURL
        }

        let data = try Data(contentsOf: url)

        let decoded = try JSONDecoder().decode(NewsResponse.self, from: data)
        return decoded.articles
    }
}

