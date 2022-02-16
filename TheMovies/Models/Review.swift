//
//  Review.swift
//  TheMovies
//
//  Created by admin1 on 16.02.2022.
//

import Foundation

struct ReviewResponse: Codable {
    var results: [Review]
}

struct Review: Codable, Identifiable {
    var id: String?
    var author: String?
    var content: String?
    
}
