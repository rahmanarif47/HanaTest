//
//  PokemonListEntity.swift
//  HanaTest
//
//  Created by Arif Rahman Sidik on 12/01/24.
//

import Foundation

// MARK: - CardObject
struct PokemonListEntity: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let id, name, supertype: String
    let subtypes: [String]
    let hp: String
    let types, evolvesTo, rules: [String]
    let attacks: [Attack]
    let weaknesses: [Weakness]
    let retreatCost: [String]
    let convertedRetreatCost: Int
    let dataSet: Set
    let number, artist, rarity: String
    let nationalPokedexNumbers: [Int]
    let legalities: Legalities
    let images: DataImages
    let tcgplayer: Tcgplayer

    enum CodingKeys: String, CodingKey {
        case id, name, supertype, subtypes, hp, types, evolvesTo, rules, attacks, weaknesses, retreatCost, convertedRetreatCost
        case dataSet = "set"
        case number, artist, rarity, nationalPokedexNumbers, legalities, images, tcgplayer
    }
}

// MARK: - Attack
struct Attack: Codable {
    let name: String
    let cost: [String]
    let convertedEnergyCost: Int
    let damage, text: String
}

// MARK: - Set
struct Set: Codable {
    let id, name, series: String
    let printedTotal, total: Int
    let legalities: Legalities
    let ptcgoCode, releaseDate, updatedAt: String
    let images: SetImages
}

// MARK: - SetImages
struct SetImages: Codable {
    let symbol, logo: String
}

// MARK: - Legalities
struct Legalities: Codable {
    let unlimited, expanded: String
}

// MARK: - DataImages
struct DataImages: Codable {
    let small, large: String
}

// MARK: - Tcgplayer
struct Tcgplayer: Codable {
    let url: String
    let updatedAt: String
    let prices: Prices
}

// MARK: - Prices
struct Prices: Codable {
    let holofoil: Holofoil
}

// MARK: - Holofoil
struct Holofoil: Codable {
    let low: Int
    let mid, high, market, directLow: Double
}

// MARK: - Weakness
struct Weakness: Codable {
    let type, value: String
}
