//
//  ArticlesCollectionViewCell.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 19/07/23.
//

import UIKit
import SwipeCellKit

class ArticlesCollectionViewCell: SwipeCollectionViewCell {
    static let identifier = "ArticlesCollectionViewCell"
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "")
        image.backgroundColor = .systemGray
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var category: UILabel = {
        let label = UILabel()
        label.text = "category"
        label.textColor = UIColor(red: 0.11, green: 0.73, blue: 0.33, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configureConstraints() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(image)
        contentView.addSubview(title)
        contentView.addSubview(category)
        
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            image.heightAnchor.constraint(equalToConstant: contentView.frame.height - 80),
            
            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            category.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            category.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            category.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
}
