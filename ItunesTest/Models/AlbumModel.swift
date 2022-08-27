//
//  AlbumModel.swift
//  ItunesTest
//
//  Created by Артур Дохно on 27.08.2022.
//

import Foundation

struct AlbumModel: Codable {
    let results: [Album]
}

struct Album: Codable {
    let artistName: String
    let collectionName: String
    let artworkUrl100: String?
    let trackCount: Int
    let releaseDate: String
}
