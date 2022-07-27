//
//  SourcesViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit

class SourcesViewController: UIViewController {
    
    private var sourcesCollectionView = SourcesCollectionView()
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(sourcesCollectionView)
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.delegate = self
        
        sourcesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sourcesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sourcesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        sourcesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        sourcesCollectionView.set(cells: Sources.items())
    }
}


extension SourcesViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
