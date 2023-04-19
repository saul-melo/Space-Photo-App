//
//  URL+Helpers.swift
//  SpacePhoto
//
//  Created by Saul Melo on 10/27/19.

import Foundation

extension URL {
    // Map the given queries to the URL
    func withQueries(_ queries: [String:String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
    
    // Set the URL's scheme to https
    func withHTTPS() -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.scheme = "https"
        return components?.url
    }
}
