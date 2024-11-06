//
//  SourcesCollectionViewCell.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit

class SourcesCollectionViewCell: UICollectionViewCell {
    static let identifier = "SourcesCollectionViewCell"
    
    lazy var color: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 30
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var nameTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        title.textColor = .secondaryLabel
        title.numberOfLines = 0
        title.textAlignment = .center
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
        contentView.layer.cornerRadius = 20
    }
    
    //MARK: - Set constraints
    
    private func configureConstraints() {
        contentView.addSubview(color)
        contentView.addSubview(category)
        contentView.addSubview(nameTitle)
        
        NSLayoutConstraint.activate([
            nameTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10),
            nameTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10),
            
            category.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            category.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            color.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            color.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            color.heightAnchor.constraint(equalToConstant: 20),
            color.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }  
}
