//
//  Network.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 28/07/22.
//
import Foundation

class Network {
    
    func request(catName: String, completion: @escaping(Result<Articles, Error>) -> Void) {
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=de&category=\(catName)&apiKey=5ed9b9eb9b7746b8a925c87ab583ccfa"
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(url)
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    //completion(nil, error)
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let news = try JSONDecoder().decode(Articles.self, from: data)
                    print(news)
                    completion(.success(news))
                }catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}



