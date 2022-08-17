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
    private var timer: Timer?
    var key:String = "5ed9b9eb9b7746b8a925c87ab583ccfa"
    
    private var sourcesCollectionView: SourcesCollectionView!
    
    private var sourcesCollectionViewCell = SourcesCollectionViewCell()
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sourcesCollectionView = SourcesCollectionView(nav: self.navigationController!)
        navigationController?.navigationBar.prefersLargeTitles = true
        // sourcesCollectionView.indicator.center = view.center
        
        network.fetchSources(apiKey: key) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.sourcesCollectionView.sources = response
                self?.sourcesCollectionView.reloadData()
                self?.sourcesCollectionView.indicator.stopAnimating()
            case .failure(let error):
                print("error", error)
            }
        }
        
        view.addSubview(sourcesCollectionView)
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        
        
        sourcesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sourcesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sourcesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        sourcesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
}


extension SourcesViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [self] (_) in
            self.network.search(apiKey: key, searchText: searchText) { [weak self] (result) in
                switch result {
                case .success(let response):
                    self?.sourcesCollectionView.articles = response
                    self?.sourcesCollectionView.reloadData()
                case .failure(let error):
                    print("error", error)
                }
            }
        })
    }
}
