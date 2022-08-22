//
//  Network.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 28/07/22.
//
import Foundation
import CoreData
import UIKit

class NetworkService {
    
    // MARK: - NEWS API
    
    //        apiKey = "5ed9b9eb9b7746b8a925c87ab583ccfa"
    //        apiKey = "b39c620e1c3a4366af54ea491dbf78cb"
    //        apiKey = "bf7fbe95ff8a449ea7100170b76e4c8c"
    //        apiKey = "8a08b923eb6f47619e3cbb0fa7c4e114"
    //        apiKey = "7080c2d581e44d4ead3dc445950f28eb"
    //        apiKey = "8daa6dab2df841e98b029ecbae2af259"
    
    // MARK: - Article data
    
    func fetchCategory(catName: String, kind: String, apiKey: String, page: String, pageNumber: Int, completion: @escaping(Result<Articles, Error>) -> Void) {
        

        let urlString = "https://newsapi.org/v2/top-headlines\(kind)\(catName)\(page)\(pageNumber)&language=en&apiKey=\(apiKey)"
        print(urlString)
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(url)
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
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
    
    
    // MARK: - Source data
    
    func fetchSources(apiKey: String, completion: @escaping(Result<Sources, Error>) -> Void) {

        let urlString = "https://newsapi.org/v2/top-headlines/sources?language=en&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(url)
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let news = try JSONDecoder().decode(Sources.self, from: data)
                    print(news)
                    completion(.success(news))
                }catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    func search(apiKey: String, searchText: String, completion: @escaping(Result<Articles, Error>) -> Void) {

        let urlString = "https://newsapi.org/v2/everything?q=\(searchText)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(url)
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
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

    func fetchArticles(apiKey: String, sources: String, completion: @escaping(Result<Articles, Error>) -> Void) {
        

        let urlString = "https://newsapi.org/v2/top-headlines?sources=\(sources)&apiKey=\(apiKey)"
        print(urlString)
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(url)
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
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



