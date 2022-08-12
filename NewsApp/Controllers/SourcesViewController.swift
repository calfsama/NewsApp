//
//  SourcesViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit

class SourcesViewController: UIViewController {

    var network = NetworkService()
    var sources: Sources?
    var key:String = "8a08b923eb6f47619e3cbb0fa7c4e114"
    
    private var sourcesCollectionView: SourcesCollectionView!
    
    private var sourcesCollectionViewCell = SourcesCollectionViewCell()
    
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sourcesCollectionView = SourcesCollectionView(nav: self.navigationController!)
        
        network.fetchSources(apiKey: key) { [weak self] (result) in
        switch result {
        case .success(let response):
            self?.sourcesCollectionView.sources = response
            //self?.sourcesCollectionView.set(data: response)
            self?.sourcesCollectionView.reloadData()
        case .failure(let error):
            print("error", error)
        }
    }

        view.addSubview(sourcesCollectionView)
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.delegate = self
        
        sourcesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sourcesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sourcesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        sourcesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                            
    }
}


extension SourcesViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
