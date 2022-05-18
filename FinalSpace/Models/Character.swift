//
//  Character.swift
//  FinalSpace
//
//  Created by Василий Полторак on 15.05.2022.
//

struct Character: Decodable {
    let name: String?
    let img_url: String?
    let status: String?
    let species: String?
    let gender: String?
    let alias: [String]?
    let origin: String?
}

struct Episode: Decodable {
    let name: String?
    let img_url: String?
    let air_date: String?
    let director: String?
    let writer: String?
    let characters: [String]?
}
