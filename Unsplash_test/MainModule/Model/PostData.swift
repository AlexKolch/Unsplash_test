//
//  PostData.swift
//  Unsplash_test
//
//  Created by Алексей Колыченков on 20.06.2025.
//

import Foundation

struct PostData: Decodable {
    let description: String?
    let altDescription: String?
    let color: String
    let likes: Int
    let urls: Urls
    
    // MARK: - Urls
    struct Urls: Decodable {
        let thumb: String
    }
    
    enum CodingKeys: String, CodingKey {
        case description
        case altDescription = "alt_description"
        case color
        case likes, urls
    }
}
