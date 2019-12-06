//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Saul Melo Lira on 10/27/19.

import Foundation

class PhotoInfoController {
    // Fetch photo data from the remote server and pass it into the completion handler as a PhotoInfo object
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        
        // Set the base URL
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        // A query dictionary sets the API key and the definition of the photos to be fetched
        let query: [String:String] = [
            "api_key":"DEMO_KEY",
            "hd":"true"
        ]
        
        // Append the queries to the baseURL
        let url = baseURL.withQueries(query)!
        
        // Decode the photo data using an instance of JSONDecoder in a DataTask
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
                completion(photoInfo)
            } else {
                print("Either no data was returned, or data was not properly decoded")
                completion(nil)
            }
        }
        task.resume()
    }
}
