//
//  LocalDataStorage.swift
//  MedibankAssignment
//
//  Created by Rohit  on 13/2/2023.
//

import Foundation

protocol LocalStorage {
    func getArticles()-> [Article]
    func addArticleToLocal(item: Article)
    func deleteArticleFromLocal(item: Article)
}

struct LocalDataStorage: LocalStorage {
    private let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func getArticles()-> [Article] {
        do {
            let fileURL = try FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(fileName)
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let items = try decoder.decode([Article].self, from: data)
            return items
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func addArticleToLocal(item: Article) {
        do {
            let fileURL = try FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(fileName)
            
            var array = getArticles()
            array.append(item)

            let encoder = JSONEncoder()
            try encoder.encode(array).write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteArticleFromLocal(item: Article) {
        do {
            let fileURL = try FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(fileName)
            var array = getArticles()
            guard let index = array.firstIndex(where: {$0.title == item.title}) else { return }
            array.remove(at: index)
            let encoder = JSONEncoder()
            try encoder.encode(array).write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
}
