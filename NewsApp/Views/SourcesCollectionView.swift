//
//  SourcesCollectionView.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit

class SourcesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    
    
    var cells = [Sources]()
    
    
    init() {
    let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
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
        cell.imageTitle.backgroundColor = cells[indexPath.row].color
        //cell.imageTitle.backgroundColor = UIColor(named: "purple")
        cell.nameTitle.text = cells[indexPath.row].title
        cell.category.text = cells[indexPath.row].category
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth, height: 200)
    }
    
    
    
    
}
