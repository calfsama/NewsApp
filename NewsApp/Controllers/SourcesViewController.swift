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
    var sources: String = ""
    var key: String = "8daa6dab2df841e98b029ecbae2af259"
    private var sourcesCollectionView: SourcesCollectionView!
    private var sourcesCollectionViewCell = SourcesCollectionViewCell()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourcesCollectionView = SourcesCollectionView(nav: self.navigationController!)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchController.searchBar.delegate = self
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
        view.addSubview(sourcesCollectionView)
        navigationItem.searchController = searchController
//        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        sourcesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sourcesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sourcesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        sourcesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       // searchData = sourcesCollectionView.sources?.sources
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//
//        filterContentForSearchText(searchController.searchBar.text!)
//    }
    
//    func filterContentForSearchText(_ searchText: String) {
//        print(searchData)
////        searchData = sourcesCollectionView.sources?.sources?.filter({ (source: Source ) -> Bool in
////            return source.name?.lowercased().contains(searchText.lowercased()) ?? (0 != 0)
////        })
////        sourcesCollectionView.reloadData()
//    }
    

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
