//
//  Character.swift
//  FinalSpace
//
//  Created by Василий Полторак on 15.05.2022.
//

enum DataType: String {
    case character
    case episode
}

struct Character: Decodable {
    let type: String
    let name: String?
    let imageUrl: String?
    let status: String?
    let species: String?
    let gender: String?
    let alias: [String]?
    let origin: String?
    
    init(characterData: [String: Any]) {
        self.type = DataType.character.rawValue
        self.name = characterData["name"] as? String
        self.imageUrl = characterData["img_url"] as? String
        self.status = characterData["status"] as? String
        self.species = characterData["species"] as? String
        self.gender = characterData["gender"] as? String
        self.alias = characterData["alias"] as? [String]
        self.origin = characterData["origin"] as? String
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let charactersData = value as? [[String: Any]] else { return [] }
        return charactersData.compactMap { Character(characterData: $0) }
    }
    
}

struct Episode: Decodable {
    let type: String
    let name: String?
    let imageUrl: String?
    let airDate: String?
    let director: String?
    let writer: String?
    let characters: [String]?
    
    init(episodeData: [String: Any]) {
        self.type = DataType.episode.rawValue
        self.name = episodeData["name"] as? String
        self.imageUrl = episodeData["img_url"] as? String
        self.airDate = episodeData["air_date"] as? String
        self.director = episodeData["director"] as? String
        self.writer = episodeData["writer"] as? String
        self.characters = episodeData["characters"] as? [String]
    }
    
    static func getEpisodes(from value: Any) -> [Episode] {
        guard let episodesData = value as? [[String: Any]] else { return [] }
        return episodesData.compactMap { Episode(episodeData: $0) }
    }
}
