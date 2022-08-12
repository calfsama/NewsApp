//
//  CategoriesViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    private var categoriesCollectionView: CategoriesCollectionView!
    
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesCollectionView = CategoriesCollectionView(nav: self.navigationController!)
        
        searchBarController()
        configureConstraints()
        
        categoriesCollectionView.set(cells: Categories.items())
 
    }
    
    func searchBarController() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.delegate = self
    }
    
    private func configureConstraints() {
        
        
        view.addSubview(categoriesCollectionView)
        
        categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        categoriesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        categoriesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
   
}


extension CategoriesViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
