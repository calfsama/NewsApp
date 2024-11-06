//
//  ArticlesCollectionView.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 19/07/23.
//

import UIKit
import Kingfisher
import SwipeCellKit

class ArticlesCollectionView: UICollectionView {
    var defaultOptions = SwipeOptions()
    var isSwipeRightEnabled = true
    var buttonDisplayMode: ButtonDisplayMode = .titleAndImage
    var buttonStyle: ButtonStyle = .backgroundColor
    var data: [Any] = []
    var articles: Articles?
    let network = NetworkService()
    var navigationController: UINavigationController
    var pageNumber : Int = 1
    var isLoadingList : Bool = false
    var news = [News]()
    var titleName: String = ""
    var type: String = ""
    var nameOfTitle: String = ""
    var page: String = ""
    var searchText: String = ""
    var key: String = "8daa6dab2df841e98b029ecbae2af259"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    init(nav: UIViewController) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.navigationController = nav as! UINavigationController
        super.init(frame: .zero, collectionViewLayout: layout)
        register(ArticlesCollectionViewCell.self, forCellWithReuseIdentifier: ArticlesCollectionViewCell.identifier)
        layout.minimumLineSpacing = 20
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        delegate = self
        dataSource = self
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
                self.pageNumber = self.articles?.totalResults ?? 2
                self.data.append(contentsOf: articles)
                self.reloadData()
//                self.table?.stopSkeletonAnimation()
//                self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            case .failure(let error):
                print("error", error)
            }
        }
    }
}
extension ArticlesCollectionView: SwipeCollectionViewCellDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        let email = data[indexPath.row]
        
//        if orientation == .left {x
//            guard isSwipeRightEnabled else { return nil }
            
            let delete = SwipeAction(style: .destructive, title: nil) { action, indexPath in
                self.data.remove(at: indexPath.row)
                }
                configure(action: delete, with: .trash)
                
                return [delete]
//        }
//        else {
//            guard isSwipeRightEnabled else { eturn nil }
//
//
//            let delete = SwipeAction(style: .destructive, title: nil) { action, indexPath in
//                self.data.remove(at: indexPath.row)
//            }
//            configure(action: delete, with: .trash)
//
//            return [delete]
//        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        if data.count == 0 {
            emptyLabel.text = "No Bookmarks"
            emptyLabel.textColor = .gray
            emptyLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
            emptyLabel.textAlignment = NSTextAlignment.center
            self.backgroundView = emptyLabel
            return 0
        }
        else {
            emptyLabel.text = ""
            self.backgroundView = emptyLabel
            return data.count
        }
    }
    
    func configure(action: SwipeAction, with descriptor: ActionDescriptor) {
        action.title = descriptor.title(forDisplayMode: buttonDisplayMode)
        action.image = descriptor.image(forStyle: buttonStyle, displayMode: buttonDisplayMode)
        
        switch buttonStyle {
        case .backgroundColor:
            action.backgroundColor = descriptor.color(forStyle: buttonStyle)
        case .circular:
            action.backgroundColor = .clear
            action.textColor = descriptor.color(forStyle: buttonStyle)
            action.font = .systemFont(ofSize: 13)
            action.transitionDelegate = ScaleTransition.default
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticlesCollectionViewCell.identifier, for: indexPath) as! ArticlesCollectionViewCell
        cell.delegate = self
        cell.configureConstraints()
        if let data = data[indexPath.row] as? Article{
            cell.title.text =  data.title
            cell.category.text = data.source?.name
            cell.image.kf.indicatorType = .activity
            cell.image.kf.setImage(with: URL(string: data.urlToImage ?? ""))
        }
        else if let data = data[indexPath.row] as? News{
            cell.title.text =  data.title
            cell.category.text = data.source
            cell.image.kf.indicatorType = .activity
            cell.image.kf.setImage(with: URL(string: data.image ?? ""))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 2.1 )
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        if let data = data[indexPath.row] as? Article{
            vc.urlString = data.url ?? ""
            vc.titleArticle = data.title ?? ""
            vc.source = data.source?.name ?? ""
            vc.image = data.urlToImage ?? ""
            self.navigationController.pushViewController(vc, animated: true)
        }
        else if let data = data[indexPath.row] as? News {
            vc.urlString = data.url ?? ""
            vc.titleArticle = data.title ?? ""
            vc.source = data.source ?? ""
            vc.image = data.image ?? ""
            self.navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 {
            print(pageNumber)
            for i in 1...5 {
                pageNumber+=1
                fetchFromApi()
            }
        }
    }
}


