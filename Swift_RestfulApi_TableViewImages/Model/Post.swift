//
//  Post.swift
//  Swift_RestfulApi_TableViewImages
//
//  Created by JJ on 26/09/24.
//
import Foundation

// Model
struct Post: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String         // Full-sized image URL
    let thumbnailUrl: String // Thumbnail image URL
}
