//
//  Models.swift
//  CustomCells
//
//  Created by Tomiris Negmatova on 25/07/22.
//
import Foundation
import UIKit


// MARK: -  Categories model

struct Categories{
    var image: UIImage
    var title: String
    
    
    static func items() -> [Categories] {
        let first = Categories(image: UIImage(named: "general")!, title: "General")
        let second = Categories(image: UIImage(named: "business")!, title: "Business")
        let third = Categories(image: UIImage(named: "science")!, title: "Science")
        let fourth = Categories(image: UIImage(named: "technology")!, title: "Technology")
        let fifth = Categories(image: UIImage(named: "health")!, title: "Health")
        let sixth = Categories(image: UIImage(named: "entertainment")!, title: "Entertainment")
        let seventh = Categories(image: UIImage(named: "sport")!, title: "Sports")
        
        return [first, second, third, fourth, fifth, sixth, seventh]
    }
    
}

//MARK: - Set constants

struct Constants {

    static let leftDistance: CGFloat = 23
    static let rightDistance: CGFloat = 23
    static let itemLineSpacing: CGFloat = 20
}
// MARK: - Bookmarks model

struct Models {
    var imageName: String
    var title: String
    var source: String
}




