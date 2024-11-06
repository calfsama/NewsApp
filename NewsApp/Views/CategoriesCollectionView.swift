//
//  CategoriesCollectionView.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit

class CategoriesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
   
    var cells = [Categories]()
    var articles: Articles?
    var navigationController: UINavigationController
    var categoryViewController = CategoriesViewController()
    var apiViewController = ApiViewController()
    
    init(nav: UIViewController) {
    let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.navigationController = nav as! UINavigationController
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .systemBackground
        delegate = self
        dataSource = self
        register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = Constants.itemLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        showsVerticalScrollIndicator = false
    }
    
    func set(cells: [Categories]) {
        self.cells = cells
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }  
}
extension CategoriesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
        
        cell.image.image = cells[indexPath.row].image
        cell.nameTitle.text = cells[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.1 * 0.92, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ApiViewController") as! ApiViewController
        vc.nameOfTitle = cells[indexPath.row].title
        vc.titleName = cells[indexPath.row].title
        vc.type = "?category="
        vc.page = "&page="
        self.navigationController.pushViewController(vc, animated: true)
    }
}
