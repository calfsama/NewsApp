//
//  EntertainmentCollectionView.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 18/07/23.
//

import UIKit
import Kingfisher

class EntertainmentCollectionView: UICollectionView {
    let network = NetworkService()
    var pageNumber : Int = 1
    var articles: Articles?
    var titleName: String = "entertainment"
    var type: String = "?category="
    var nameOfTitle: String = ""
    var page: String = "&page="
    var searchText: String = ""
    var navigationController: UINavigationController
    var key: String = "8daa6dab2df841e98b029ecbae2af259"

    init(nav: UIViewController) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.navigationController = nav as! UINavigationController
        super.init(frame: .zero, collectionViewLayout: layout)
        register(MainCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: MainCategoriesCollectionViewCell.identifier)
        layout.minimumLineSpacing = 20
        contentInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        delegate = self
        dataSource = self
        fetchFromApi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchFromApi(){
        self.network.fetchCategory(catName: self.titleName.lowercased(), kind: self.type,apiKey: self.key, page: page, pageNumber: self.pageNumber) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                guard var articles = response.articles else {return}
//                self.pageNumber = self.articles?.totalResults ?? 2
                self.articles = response
                self.reloadData()
                
//                self.table?.stopSkeletonAnimation()
//                self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            case .failure(let error):
                print("error", error)
            }
        }
    }
}
extension EntertainmentCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoriesCollectionViewCell.identifier, for: indexPath) as! MainCategoriesCollectionViewCell
        cell.configureConstraints()
        let article = articles?.articles?[indexPath.row]
        cell.title.text =  article?.title
        cell.category.text = article?.source?.name
        cell.image.kf.indicatorType = .activity
        cell.image.kf.setImage(with: URL(string: article?.urlToImage ?? ""))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.1 * 0.8, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        let article = articles?.articles?[indexPath.row]
        vc.urlString = article?.url ?? ""
        vc.titleArticle = article?.title ?? ""
        vc.source = article?.source?.name ?? ""
        vc.image = article?.urlToImage ?? ""
        self.navigationController.pushViewController(vc, animated: true)
    }
}
