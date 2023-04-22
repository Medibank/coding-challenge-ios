//
//  Singleton.swift
//  MedibankAssignment
//
//  Created by Rohit  on 12/2/2023.
//

import Foundation

extension Array where Element: AnyObject {
    mutating func removeFirst(object: AnyObject) {
        guard let index = firstIndex(where: {$0 === object}) else { return }
        remove(at: index)
    }
}

protocol SharedState {
    var sources: [Source] { get }
    func addSource(source: Source)
    func removeSource(source: Source)
    func getCommaSeparatedSources() -> String
}

class Singleton: SharedState {
    var sources: [Source] = []
    static let shared = Singleton()
    
    func addSource(source: Source) {
        sources.append(source)
    }
    
    func getCommaSeparatedSources() -> String {
        let sources = sources.map{ $0.id }.joined(separator: ",")
        return sources
    }
    
    func removeSource(source: Source) {
        sources.removeFirst(object: source)
    }
}
