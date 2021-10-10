//
//  Album.swift
//  CopyBook
//
//  Created by user204006 on 10/10/21.
//

import Foundation

// MARK: - Album
struct Album: Codable {
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}
