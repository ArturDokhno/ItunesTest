//
//  SongsModel.swift
//  ItunesTest
//
//  Created by Артур Дохно on 27.08.2022.
//

import Foundation

struct SongsModel: Codable {
    let results: [Song]
}

struct Song: Codable {
    let trackName: String?
}
