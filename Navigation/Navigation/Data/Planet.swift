//
//  Planet.swift
//  Navigation
//
//  Created by Денис Штоколов on 01.09.2022.
//

import Foundation

struct Planet: Decodable {
    let name: String
    let rotation_period: String
    let orbital_period: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surface_water: String
    let population: String
    let residents: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
}
