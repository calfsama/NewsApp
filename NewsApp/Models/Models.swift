//
//  Models.swift
//  CustomCells
//
//  Created by Tomiris Negmatova on 25/07/22.
//
import Foundation
import UIKit


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

//struct Sources {
//    var colour: UIColor
//    var label: String
//    var category: String
//    var color: String
//
//
//
//    static func items() -> [Sources] {
//        let first = Sources(colour: UIColor(named: "gray2")!, label: "ABC News", category: "General", color: "")
//        let second = Sources(colour: UIColor(named: "gray2")!, label: "Aftenposten", category: "General", color: "")
//        let third = Sources(colour: UIColor(named: "gray2")!, label: "Axios", category: "General", color: "")
//        let fourth = Sources(colour: UIColor(named: "gray2")!, label: "Ars Technica", category: "Technology", color: "")
//        let fifth = Sources(colour: UIColor(named: "gray2")!, label: "Al Jazeera English", category: "General", color: "")
//        let sixth = Sources(colour: UIColor(named: "gray2")!, label: "Ary News", category: "General", color: "")
//        let seventh = Sources(colour: UIColor(named: "gray2")!, label: "BBC News", category: "General", color: "")
//        let eighth = Sources(colour: UIColor(named: "gray2")!, label: "BBC Sport", category: "Sports", color: "")
//        let ninth = Sources(colour: UIColor(named: "gray2")!, label: "Buzzfeed", category: "Entertainment", color: "")
//        let tenth = Sources(colour: UIColor(named: "gray2")!, label: "Crypto Coins News", category: "Technology", color: "")
//        let eleventh = Sources(colour: UIColor(named: "gray2")!, label: "Engadget", category: "Technology", color: "")
//        let twelveth = Sources(colour: UIColor(named: "gray2")!, label: "El Mundo", category: "General", color: "")
//        let thiteenth = Sources(colour: UIColor(named: "gray2")!, label: "ESPN", category: "Sports", color: "")
//        let fourteenth = Sources(colour: UIColor(named: "gray2")!, label: "Medical News Today", category: "Health", color: "")
//        let fifteenth = Sources(colour: UIColor(named: "gray2")!, label: "National Geographic", category: "Science", color: "")
//        let sixteenth = Sources(colour: UIColor(named: "gray2")!, label: "New Scientist", category: "Science", color: "")
//
//
//        return [first,second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelveth, thiteenth, fourteenth, fifteenth, sixteenth]
//    }
//}
//
struct Constants {

    static let leftDistance: CGFloat = 10
    static let rightDistance: CGFloat = 10
    static let itemLineSpacing: CGFloat = 20
    static let itemWidth = (UIScreen.main.bounds.width - Constants.leftDistance - Constants.rightDistance - Constants.itemLineSpacing) / 2

}

struct Models {
    var imageName: String
    var title: String
    var source: String
}




