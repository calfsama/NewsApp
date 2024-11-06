//
//  MainCategoriesCollectionReusableView.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 18/07/23.
//

import UIKit

class MainCategoriesCollectionReusableView: UICollectionReusableView {
    static let identifier = "MainCategoriesCollectionReusableView"
    
    lazy var category: UILabel = {
        let label = UILabel()
        label.text = "Trending"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var viewAllButton: UIButton = {
       let button = UIButton()
        button.setTitle("View All", for: .normal)
        button.backgroundColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func configureConstraints() {
        addSubview(category)
        addSubview(viewAllButton)
        
        NSLayoutConstraint.activate([
            category.centerYAnchor.constraint(equalTo: centerYAnchor),
            category.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            
            viewAllButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            viewAllButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
