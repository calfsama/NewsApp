//
//  SourcesViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit
import SwiftUI
import simd

class SourcesViewController: UIViewController {
    
    var network = NetworkService()
    var searchData: Sources?
    var data: Sources?
    var key: String = "8daa6dab2df841e98b029ecbae2af259"
    private var sourcesCollectionView: SourcesCollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourcesCollectionView = SourcesCollectionView(nav: self.navigationController!)
        navigationController?.navigationBar.prefersLargeTitles = true
        configureConstraints()
        setSearchBar()
        fetchSources()
        }
    
    func fetchSources() {
        network.fetchSources(apiKey: key) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.sourcesCollectionView.sources = response
                self?.searchData = response
                self?.data = response
                self?.sourcesCollectionView.reloadData()
                self?.sourcesCollectionView.indicator.stopAnimating()
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func configureConstraints() {
        view.addSubview(sourcesCollectionView)
        
        NSLayoutConstraint.activate([
            sourcesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sourcesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sourcesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            sourcesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
}

extension SourcesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        if !searchText.isEmpty{} else{
            data = searchData
        }
        sourcesCollectionView.sources?.sources = searchData?.sources?.filter({ (source: Source )in
            return (source.name?.lowercased().contains(searchText.lowercased()))!
        })
        sourcesCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchSources()
    }
}
