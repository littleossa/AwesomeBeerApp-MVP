//
//  Beer.swift
//  AwesomeBeerApp-MVP
//
//  Created by Osamu Hiraoka on 2021/07/19.
//

import Foundation

struct Beer: Decodable {
    let id: Int
    let name: String
    let tagline: String
    let firstBrewed: String
    let description: String
}
