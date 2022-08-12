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
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var nameTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        title.textColor = .secondaryLabel
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var category: UILabel = {
        let category = UILabel()
        category.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        category.textColor = .secondaryLabel
        category.translatesAutoresizingMaskIntoConstraints = false
        return category
    }()
    
    lazy var color: UIButton = {
        let color = UIButton()
        color.backgroundColor = .gray
        color.layer.cornerRadius = 30
        color.layer.masksToBounds = true
        color.translatesAutoresizingMaskIntoConstraints = false
        return color
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    //MARK: - Set constraints
    
    private func configureConstraints() {
        
        contentView.addSubview(imageTitle)
        contentView.addSubview(nameTitle)
        contentView.addSubview(category)
        contentView.addSubview(color)
        
        NSLayoutConstraint.activate([
            
            
            imageTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameTitle.leadingAnchor.constraint(equalTo: imageTitle.leadingAnchor,constant: 50),
            nameTitle.trailingAnchor.constraint(equalTo: imageTitle.trailingAnchor,constant: 50),
            
            category.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            category.topAnchor.constraint(equalTo: nameTitle.bottomAnchor, constant: 53),
            

            color.topAnchor.constraint(equalTo: nameTitle.bottomAnchor,constant: 44),
            color.trailingAnchor.constraint(equalTo: category.leadingAnchor),
            color.widthAnchor.constraint(equalToConstant: 20),
            color.heightAnchor.constraint(equalToConstant: 30)
            
            
            
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
