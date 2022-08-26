//
//  UserModel.swift
//  ItunesTest
//
//  Created by Артур Дохно on 26.08.2022.
//

import Foundation

struct User: Codable {
    let firstName: String
    let secondName: String
    let phone: String
    let email: String
    let password: String
    let age: Date
}
