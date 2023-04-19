//
//  SearchResponseModel.swift
//  Space!
//
//  Created by Dave Piernick on 4/18/23.
//

import Foundation

struct ResultsModel: Codable {
    var collection: ResultCollection?
}

struct ResultCollection: Codable {
    var items: [Item]?
    var metadata: MetaData?
}

struct Item: Codable, Hashable {
    var data: [ItemData]?
    var links: [Link]?
}

struct Link: Codable, Hashable {
    var href: String?
}

struct ItemData: Codable, Hashable {
    var title: String?
    var description: String?
}

struct MetaData: Codable {
    var total_hits: Int
}
