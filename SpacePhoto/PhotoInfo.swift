//
//  PhotoInfo.swift
//  SpacePhoto
//
//  Created by Saul Melo Lira on 10/27/19.

import Foundation

struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var mediaType: String
    var copyright: String?
    
    // Custom  coding keys
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case mediaType = "media_type"
        case copyright
    }
    
    // Initialize the variables used in decoding 
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        self.mediaType = try valueContainer.decode(String.self, forKey: CodingKeys.mediaType)
        self.copyright = try valueContainer.decode(String.self, forKey: CodingKeys.copyright)
    }
}
