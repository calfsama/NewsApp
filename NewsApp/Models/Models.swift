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
    var color: UIColor
    var title: String
    
    static func items() -> [Categories] {
        let first = Categories(color: UIColor(named: "green")!, title: "General")
        let second = Categories(color: UIColor(named: "light green")!, title: "Business")
        let third = Categories(color: UIColor(named: "orange")!, title: "Science")
        let fourth = Categories(color: UIColor(named: "red")!, title: "Technology")
        let fifth = Categories(color: UIColor(named: "yellow")!, title: "Health")
        let sixth = Categories(color: UIColor(named: "blue")!, title: "Entertainment")
        let seventh = Categories(color: UIColor(named: "purple")!, title: "Sports")
        
        return [first, second, third, fourth, fifth, sixth, seventh]
    }
    
}

//MARK: - Set constants

struct Constants {

    static let leftDistance: CGFloat = 10
    static let rightDistance: CGFloat = 10
    static let itemLineSpacing: CGFloat = 20
    static let itemWidth = (UIScreen.main.bounds.width - Constants.leftDistance - Constants.rightDistance - Constants.itemLineSpacing) / 2

}
// MARK: - Bookmarks model

struct Models {
    var imageName: String
    var title: String
    var source: String
}




