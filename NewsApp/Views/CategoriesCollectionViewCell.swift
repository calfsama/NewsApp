//
//  CategoriesCollectionViewCell.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoriesCollectionViewCell"
    
    lazy var imageTitle: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemGray
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var nameTitle: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
     func configureConstraints(){
         contentView.addSubview(imageTitle)
         contentView.addSubview(nameTitle)
         
        
        NSLayoutConstraint.activate([
            imageTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
