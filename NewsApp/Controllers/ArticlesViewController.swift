//
//  ArticlesViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 19/07/23.
//

import UIKit
import CoreData

class ArticlesViewController: UIViewController {
    var articles: ArticlesCollectionView!
    let network = NetworkService()
    var data: [Any] = []
    var pageNumber : Int = 1
    var isLoadingList : Bool = false
    var news = [News]()
    var article: Articles?
    var titleName: String = ""
    var type: String = ""
    var nameOfTitle: String = ""
    var page: String = ""
    var searchText: String = ""
    var key: String = "8daa6dab2df841e98b029ecbae2af259"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        title = nameOfTitle
        view.backgroundColor = .systemBackground
        articles = ArticlesCollectionView(nav: self.navigationController!)
        configureConstraints()
    }
    
    func configureConstraints() {
        view.addSubview(articles)
        
        NSLayoutConstraint.activate([
            articles.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            articles.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            articles.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            articles.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        table?.isSkeletonable = true
//        table?.showAnimatedGradientSkeleton()
        if titleName == "" && type == "" && searchText == ""{
            loadArticles()
        }else if page == "" && searchText == ""{
            fetchSources()
        }
        else if searchText != ""{
            search()
        }
        else {
            fetchFromApi()
        }
    }
    
    func fetchFromApi(){
        self.network.fetchCategory(catName: self.titleName.lowercased(), kind: self.type,apiKey: self.key, page: page, pageNumber: self.pageNumber) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                guard var articles = response.articles else {return}
                self.pageNumber = self.article?.totalResults ?? 2
                self.articles.data.append(contentsOf: articles)
                self.articles?.reloadData()
//                self.table?.stopSkeletonAnimation()
//                self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func search() {
        
        self.network.search(apiKey: key, searchText: searchText) { [weak self] (result) in
             switch result {
             case .success(let response):
                 guard let articles = response.articles else {return}
                 self?.articles.data = articles
                 self?.articles?.reloadData()
//                 self?.table?.stopSkeletonAnimation()
//                 self?.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
             case .failure(let error):
                 print("error", error)
             }
         }
    }
    
    func fetchSources() {
        self.network.fetchArticles(apiKey: key, sources: titleName ) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                guard var articles = response.articles else {return}
                self.articles.data = articles
                self.articles.reloadData()
//                self.table?.stopSkeletonAnimation()
//                self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    func loadArticles() {
        title = "Bookmarks"
        navigationItem.largeTitleDisplayMode = .never
        let request: NSFetchRequest <News> = News.fetchRequest()
        do {
            news = try context.fetch(request)
            articles.data = news
            articles?.reloadData()
//            self.table?.stopSkeletonAnimation()
//            self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        }catch {
            print("Error fetching data from context \(error)")
        }
    }
}

