//
//  TrendingCollectionView.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 18/07/23.
//

import UIKit
import Kingfisher

class TrendingCollectionView: UICollectionView {
    var cells = [Categories]()
    let network = NetworkService()
    var pageNumber : Int = 1
    var articles: Articles?
    var titleName: String = "general"
    var type: String = "?category="
    var nameOfTitle: String = ""
    var page: String = "&page="
    var searchText: String = ""
    var navigationController: UINavigationController
    var key: String = "8daa6dab2df841e98b029ecbae2af259"
    
    init(nav: UIViewController) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.navigationController = nav as! UINavigationController
        super.init(frame: .zero, collectionViewLayout: layout)
        register(MainCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: MainCategoriesCollectionViewCell.identifier)
        layout.minimumLineSpacing = 20
        contentInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        delegate = self
        dataSource = self
       
    }
    
    func set(cells: [Categories]) {
        self.cells = cells
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    }
extension TrendingCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCategoriesCollectionViewCell.identifier, for: indexPath) as! MainCategoriesCollectionViewCell
        cell.configureConstraints()
        let article = articles?.articles?[indexPath.row]
        cell.cat.text = cells[indexPath.row].title
        cell.title.text =  article?.title
        cell.category.text = article?.source?.name
        cell.image.kf.indicatorType = .activity
        cell.image.kf.setImage(with: URL(string: article?.urlToImage ?? ""))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.1 * 0.92, height: 180)
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
