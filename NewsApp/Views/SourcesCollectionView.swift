//
//  SourcesCollectionView.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit

class SourcesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    
    
    var categories = [Categories]()
    var cells = [Sources]()
    var navigationController: UINavigationController
    
    
    init(nav: UIViewController) {
    let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.navigationController = nav as! UINavigationController
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = .systemBackground
        delegate = self
        dataSource = self
        register(SourcesCollectionViewCell.self, forCellWithReuseIdentifier: SourcesCollectionViewCell.identifier)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layout.minimumLineSpacing = Constants.itemLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistance, bottom: 0, right: Constants.rightDistance)
        
        showsVerticalScrollIndicator = false
        
        
    }
    
    func set(cells: [Sources]) {
        self.cells = cells
    }
    
    func set(categories: [Categories]) {
        self.categories = categories
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension SourcesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: SourcesCollectionViewCell.identifier, for: indexPath) as! SourcesCollectionViewCell
        cell.imageTitle.backgroundColor = cells[indexPath.row].colour
        cell.nameTitle.text = cells[indexPath.row].label
        cell.category.text = cells[indexPath.row].category
//        let cat = categories[indexPath.row].title
//        let colors = cells[indexPath.row].category
//        if colors == cat {
//            cell.color.backgroundColor = categories[indexPath.row].color
//        }
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ApiViewController") as! ApiViewController
        vc.title = cells[indexPath.row].label
        self.navigationController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "\(cells[indexPath.row].label)", style: .plain, target: nil, action: nil)
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    
    
    
    
}
