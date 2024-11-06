//
//  CategoriesCollectionViewCell.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoriesCollectionViewCell"
    
    lazy var image: UIImageView = {
        let image = UIImageView()
//        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var darkOverlay: UIView = {
        let darkOverlay = UIView(frame: image.bounds)
        darkOverlay.backgroundColor = UIColor.black.withAlphaComponent(1) // 0.5 означает 50% затемнение
        return darkOverlay
    }()
    
    lazy var nameTitle: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
        contentView.layer.cornerRadius = 20
    }
    
    // MARK: - Set Constraints
    
     func configureConstraints(){
         contentView.addSubview(image)
         image.addSubview(darkOverlay)
         contentView.addSubview(nameTitle)
         NSLayoutConstraint.activate([
            
                image.heightAnchor.constraint(equalToConstant: contentView.frame.height),
                image.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            
                nameTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                nameTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
         ])
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
