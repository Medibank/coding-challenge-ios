//
//  SourceResponse.swift
//  MedibankAssignment
//
//  Created by Rohit  on 10/2/2023.
//

import Foundation

struct SourceResponse: Codable {
    let status: String
    let sources: [Source]
}

class Source: Codable {
    let id: String
    let name: String
    let description: String
    let url: String
    let category: String
    let language: String
    let country: String
    var isSelected: Bool? = false  
}
