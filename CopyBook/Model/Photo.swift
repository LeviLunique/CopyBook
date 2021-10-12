//
//  Photo.swift
//  CopyBook
//
//  Created by user204006 on 10/11/21.
//

import Foundation
// MARK: - Photo
struct Photo: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
