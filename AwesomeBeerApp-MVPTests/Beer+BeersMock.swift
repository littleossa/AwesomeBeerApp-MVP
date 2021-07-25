//
//  Beer+Mock.swift
//  AwesomeBeerApp-MVP
//
//  Created by Osamu Hiraoka on 2021/07/19.
//

import Foundation

extension Beer {
    
    static func mockBeers() -> [Beer] {
        let beers = [
            Beer(id: 1,
                 name: "Asahi Super dry",
                 tagline: "さらりとした飲み口、キレ味さえる、いわば辛口の生ビールです。",
                 firstBrewed: "1987年",
                 description: ""),
            Beer(id: 2,
                 name: "キリン一番搾り生ビール",
                 tagline: "おいしさに妥協しない、それが一番搾り®︎製法",
                 firstBrewed: "1990年",
                 description: ""),
            Beer(id: 3,
                 name: "ヱビスビール",
                 tagline: "旨味あふれる、ふくよかなコク。",
                 firstBrewed: "1890年",
                 description: "1890年の誕生以来、本場ドイツのおいしさにこだわり続け、本物のビールの先駆者として、変わらぬおいしさを届け続けてきたヱビス。麦芽100％、ヱビス酵母、ふんだんに使用されたバイエルン産アロマホップ、そして長期熟成。吟味しつくされた原料と製法がつむぐ、旨味あふれる、ふくよかなコク。ヱビスビール。それは、唯一無二のビールです。")
        ]
        return beers
    }
}
