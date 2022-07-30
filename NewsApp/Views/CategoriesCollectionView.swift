//
//  CategoriesCollectionView.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit

class CategoriesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
   
    var cells = [Categories]()
    var navigationController: UINavigationController
    
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
        contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistance, bottom: 0, right: Constants.rightDistance)
        
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
        cell.imageTitle.backgroundColor = cells[indexPath.row].color
        cell.nameTitle.text = cells[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ApiViewController") as! ApiViewController
        vc.title = cells[indexPath.row].title
            //vc.business = "health"
        if ((indexPath.row) == 0) {
            vc.business = "general"
        }
        else if ((indexPath.row) == 1) {
            vc.business = "business"
        }
        else if ((indexPath.row) == 2) {
            vc.business = "science"
        }
        else if ((indexPath.row) == 3) {
            vc.business = "technology"
        }
        else if ((indexPath.row) == 4) {
            vc.business = "health"
        }
        else if ((indexPath.row) == 5){
            vc.business = "entertainment"
        }
        else if ((indexPath.row) == 6){
            vc.business = "sports"
        }
        self.navigationController.pushViewController(vc, animated: true)
    }
}
