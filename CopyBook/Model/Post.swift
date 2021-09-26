//
//  Post.swift
//  CopyBook
//
//  Created by user204006 on 9/26/21.
//

import Foundation
struct Post: Codable, Identifiable {
    let userId, id: Int
    let title, body: String
}
