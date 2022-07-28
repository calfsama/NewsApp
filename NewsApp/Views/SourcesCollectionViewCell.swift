//
//  SourcesCollectionViewCell.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit

class SourcesCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "SourcesCollectionViewCell"
    
    lazy var imageTitle: UIImageView = {
        let image = UIImageView()
        //image.backgroundColor = UIColor(named: "gray")
        image.backgroundColor = .label
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var nameTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.textColor = .secondaryLabel
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var category: UILabel = {
        let category = UILabel()
        category.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        category.textColor = .secondaryLabel
        category.translatesAutoresizingMaskIntoConstraints = false
        return category
    }()
    
    lazy var color: UIImageView = {
        let color = UIImageView()
        color.layer.cornerRadius = 50
        color.layer.masksToBounds = true
        color.translatesAutoresizingMaskIntoConstraints = false
        color.backgroundColor = .black
        return color
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        contentView.addSubview(imageTitle)
        contentView.addSubview(nameTitle)
        contentView.addSubview(category)
        //contentView.addSubview(color)
        
        NSLayoutConstraint.activate([
            
            
            imageTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
//            
//            color.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 20),
//            color.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 20),
//            color.topAnchor.constraint(equalTo: nameTitle.bottomAnchor,constant: 50),
//            color.trailingAnchor.constraint(equalTo: category.trailingAnchor, constant: 10),
            
            category.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            category.topAnchor.constraint(equalTo: nameTitle.bottomAnchor, constant: 50)
            
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
