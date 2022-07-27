//
//  CategoriesCollectionView.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit

class CategoriesCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    var cells = [Categories]()
    
    
    init() {
    let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = .systemBackground
        delegate = self
        dataSource = self
        register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layout.minimumLineSpacing = Constants.itemLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistance, bottom: 0, right: Constants.rightDistance)
        
        showsVerticalScrollIndicator = false
        
        
    }
    
    func set(cells: [Categories]) {
        self.cells = cells
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
        cell.imageTitle.backgroundColor = cells[indexPath.row].color
        cell.nameTitle.text = cells[indexPath.row].title
        cell.nameTitle.textAlignment = .center
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let viewController = UINavigationController(rootViewController: ArticlesViewController())
        self.inputViewController?.navigationController?.pushViewController(viewController, animated: true)
        
    }
    

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}