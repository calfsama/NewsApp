//
//  SourcesCollectionView.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 26/07/22.
//

import UIKit

class SourcesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    var sourcesViewController = SourcesViewController()
    var sources: Sources?
    var article: Articles?
    var categories = [Categories]()
    var navigationController: UINavigationController
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    init(nav: UIViewController) {
    let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        self.navigationController = nav as! UINavigationController
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .systemBackground
        delegate = self
        dataSource = self
        register(SourcesCollectionViewCell.self, forCellWithReuseIdentifier: SourcesCollectionViewCell.identifier)
        indicator.frame = CGRect(x: 170, y: 280, width: 40, height: 40)
        self.addSubview(indicator)
        self.bringSubviewToFront(indicator)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        indicator.startAnimating()
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = Constants.itemLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistance, bottom: 0, right: Constants.rightDistance)
        showsVerticalScrollIndicator = false
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SourcesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return sources?.sources?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: SourcesCollectionViewCell.identifier, for: indexPath) as! SourcesCollectionViewCell
 
        var source = sources?.sources?[indexPath.row]
        cell.nameTitle.text = source?.name
        cell.category.text = source?.category
        cell.contentView.backgroundColor = UIColor(named: "gray2")
       // let colors = source?.category
//        if colors == "general" {
//            cell.color.backgroundColor = UIColor(named: "green")
//        }
//        else if colors == "business" {
//            cell.color.backgroundColor = UIColor(named: "light green")
//        }
//        else if colors == "science" {
//            cell.color.backgroundColor = UIColor(named: "orange")
//        }
//        else if colors == "technology" {
//            cell.color.backgroundColor = UIColor(named: "red")
//        }
//        else if colors == "health" {
//            cell.color.backgroundColor = UIColor(named: "yellow")
//        }
//        else if colors == "etertainment" {
//            cell.color.backgroundColor = UIColor(named: "blue")
//        }
//        else if colors == "sports" {
//            cell.color.backgroundColor = UIColor(named: "purple")
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ApiViewController") as! ApiViewController
        vc.nameOfTitle = sources?.sources?[indexPath.row].name ?? ""
        vc.type = "?sources="
        vc.titleName = sources?.sources?[indexPath.row].id ?? ""
        self.navigationController.pushViewController(vc, animated: true)
    }
}
