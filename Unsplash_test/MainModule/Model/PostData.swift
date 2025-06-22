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
    let user: User
    
    // MARK: - Urls
    struct Urls: Decodable {
        let thumb, regular: String
    }
    
    struct User: Decodable {
        let username: String
    }
    
    enum CodingKeys: String, CodingKey {
        case altDescription = "alt_description"
        case description, color, likes, urls, user
    }
}
