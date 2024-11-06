//
//  MainViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 18/07/23.
//

import UIKit

class MainViewController: UIViewController {
    var trending: TrendingCollectionView!
    var business: BusinessCollectionView!
    var entertainment: EntertainmentCollectionView!
    var health: HealthCollectionView!
    var sports: SportsCollectionView!
    var technology: TechnologyCollectionView!
    let searchController = UISearchController(searchResultsController: ApiViewController())
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 1850)
        scrollView.backgroundColor = .systemBackground
        scrollView.showsVerticalScrollIndicator = false
        scrollView.frame = view.bounds
        return scrollView
    }()
    
    lazy var category: UILabel = {
        let label = UILabel()
        label.text = "Trending"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var viewAllButton: UIButton = {
       let button = UIButton()
        button.setTitle("View All", for: .normal)
        button.backgroundColor = .systemGray5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(viewAllAction), for: .touchUpInside)
        return button
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        health = HealthCollectionView(nav: self.navigationController!)
        sports = SportsCollectionView(nav: self.navigationController!)
        trending = TrendingCollectionView(nav: self.navigationController!)
        business = BusinessCollectionView(nav: self.navigationController!)
        technology = TechnologyCollectionView(nav: self.navigationController!)
        entertainment = EntertainmentCollectionView(nav: self.navigationController!)
        configureConstraints()
        searchBarController()
    }
    
    @objc func viewAllAction() {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "ApiViewController") as! ApiViewController
        let vc = ArticlesViewController()
        vc.nameOfTitle = "General"
        vc.titleName = "General"
        vc.type = "?category="
        vc.page = "&page="
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchBarController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    func configureConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(category)
        scrollView.addSubview(viewAllButton)
        scrollView.addSubview(trending)
        scrollView.addSubview(business)
        scrollView.addSubview(entertainment)
        scrollView.addSubview(health)
        scrollView.addSubview(sports)
        scrollView.addSubview(technology)
        
        NSLayoutConstraint.activate([
            category.topAnchor.constraint(equalTo:  scrollView.topAnchor, constant: 20),
            category.leadingAnchor.constraint(equalTo:  view.leadingAnchor, constant: 14),
            
            viewAllButton.centerYAnchor.constraint(equalTo:  category.centerYAnchor),
            viewAllButton.trailingAnchor.constraint(equalTo:  view.trailingAnchor, constant: -14),
            viewAllButton.heightAnchor.constraint(equalToConstant: 25),
            viewAllButton.widthAnchor.constraint(equalToConstant: 70),
            
            trending.topAnchor.constraint(equalTo: category.bottomAnchor, constant: 14),
            trending.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            trending.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            trending.heightAnchor.constraint(equalToConstant: 220),
            
            business.topAnchor.constraint(equalTo: trending.bottomAnchor, constant: 20),
            business.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            business.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            business.heightAnchor.constraint(equalToConstant: 220),
            
            entertainment.topAnchor.constraint(equalTo: business.bottomAnchor, constant: 20),
            entertainment.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            entertainment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            entertainment.heightAnchor.constraint(equalToConstant: 220),

            health.topAnchor.constraint(equalTo: entertainment.bottomAnchor, constant: 20),
            health.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            health.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            health.heightAnchor.constraint(equalToConstant: 220),

            sports.topAnchor.constraint(equalTo: health.bottomAnchor, constant: 20),
            sports.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            sports.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            sports.heightAnchor.constraint(equalToConstant: 220),

            technology.topAnchor.constraint(equalTo: sports.bottomAnchor, constant: 20),
            technology.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            technology.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            technology.heightAnchor.constraint(equalToConstant: 220),
            technology.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
        
    }
}
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ApiViewController") as! ApiViewController
        vc.searchText = searchBar.text!
        vc.nameOfTitle = "Results by \(searchBar.text!)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
