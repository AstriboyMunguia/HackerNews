//
//  API client.swift
//  HackerNews
//
//  Created by Eduardo Geovanni Pérez Munguía on 29/04/24.
//

import Foundation

class ApiClient {
    func getNews(completion: @escaping (Result<News, Error>) -> Void) {
        
        var request = URLRequest(url: URL(string: "http://hn.algolia.com/api/v1/search_by_date?query=androi%20d")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let _: Void = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print("Error: \(error)")
                } else {
                    print("No data received")
                }
                return
            }
            
            print(String(data: data, encoding: .utf8)!)
            
            do {
                let result = try JSONDecoder().decode(News.self, from: data)
                
                completion(.success(result))
                
            } catch {
                print("Error decoding JSON: \(error)")
                completion(.failure(error))

            }
        }.resume()
    }
}



/*import SwiftUI
import Foundation

class ApiClient {
    
    
    func getNews(completion: @escaping (Result<News, Error>) -> Void) {
        let url = URL(string: "http://hn.algolia.com/api/v1/search_by_date?query=android")!
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let error = NSError(domain: "HTTP", code: statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }

            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let hackerNews = try decoder.decode(News.self, from: data)
                    completion(.success(hackerNews))
                } else {
                    let error = NSError(domain: "Data", code: -1, userInfo: nil)
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }

} */
