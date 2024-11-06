//
//  CategoriesViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit
import FirebaseAuth

class CategoriesViewController: UIViewController {
    
    private var categoriesCollectionView: CategoriesCollectionView!
    let searchController = UISearchController(searchResultsController: ApiViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesCollectionView = CategoriesCollectionView(nav: self.navigationController!)
        searchBarController()
        configureConstraints()
        categoriesCollectionView.set(cells: Categories.items())
    }
    
    func searchBarController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    private func configureConstraints() {
        view.addSubview(categoriesCollectionView)
        
        NSLayoutConstraint.activate([
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }
}

extension CategoriesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ApiViewController") as! ApiViewController
        vc.searchText = searchBar.text!
        vc.nameOfTitle = "Results by \(searchBar.text!)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
