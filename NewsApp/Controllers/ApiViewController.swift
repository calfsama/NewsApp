//
//  ApiViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 28/07/22.
//

import UIKit
import Kingfisher
import SkeletonView
import CoreData

class ApiViewController: UIViewController, UIScrollViewDelegate {

        let network = NetworkService()
        var data: [Any] = []
        var news = [News]()
        var isLoadingList: Bool = false
        var titleName: String = ""
        var type: String = ""
        var nameOfTitle: String = ""
        var pages: String = ""
        var totalPage: Int = 1
        var currentPage: Int = 0
        var key: String = "8a08b923eb6f47619e3cbb0fa7c4e114"
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        @IBOutlet weak var table: UITableView!
    
    
    // MARK: - Set Skeleton View
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        table.isSkeletonable = true
        table.showAnimatedGradientSkeleton()
    }

        override func viewDidLoad() {
            super.viewDidLoad()
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.backBarButtonItem?.tintColor = UIColor(named: "purple")
            table.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
            table.delegate = self
            table.dataSource = self
            title = nameOfTitle
            nameOfTitle = titleName
            loadArticles()

            table.rowHeight = UITableView.automaticDimension
            table.estimatedRowHeight = 10
            
            
            
//    func getListFromServer(_ pageNumber: Int) {
//        self.isLoadingList = false
//        self.table.reloadData()
//    }
//
//    func loadMoreItemsForList() {
//        currentPage += 1
//        getListFromServer(currentPage)
//
//    }

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height) && !isLoadingList) {
//            self.isLoadingList = true
//            self.loadMoreItemsForList()
//
////            currentPage += 1
////            self.network.fetchCategory(pagination: true, catName: self.titleName.lowercased(), kind: self.lang, page: self.pages, pageNumber: self.currentPage, apiKey: self.key) { [weak self] (result) in
////            switch result {
////            case .success(let response):
////                self?.news = response
////                self?.table.reloadData()
////            case .failure(let error):
////                print("error", error)
////            }
////        }
//    }
//}
            func fetchFromApi(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.network.fetchCategory(catName: self.titleName.lowercased(), kind: self.type, page: self.pages, pageNumber: self.currentPage, apiKey: self.key) { [weak self] (result) in
                        switch result {
                        case .success(let response):
                            guard let articles = response.articles else {return}
                            self?.data = articles
                            
                            self?.table.reloadData()
                        case .failure(let error):
                            print("error", error)
                        }
                    }
                    self.table.stopSkeletonAnimation()
                    self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                })
            }
        }
    
    func loadArticles() {
        let request: NSFetchRequest <News> = News.fetchRequest()
        do {
            news = try context.fetch(request)
           data = news
        }catch {
            print("Error fetching data from context \(error)")
        }
    }
    
}
extension ApiViewController: UITableViewDelegate, SkeletonTableViewDataSource  {

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }

        func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
            UITableView.automaticNumberOfSkeletonRows
        }
    
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }
    

        func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
            return  TableViewCell.identifier
        }

        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell

               
            if let data = data[indexPath.row] as? Article{
                cell.myLabel.text =  data.title
                cell.sources.text = data.source?.name
                cell.myImage.kf.indicatorType = .activity
                cell.myImage.kf.setImage(with: URL(string: data.urlToImage ?? ""))
            }
            
            if let data = data[indexPath.row] as? News{
                cell.myLabel.text =  data.title
                cell.sources.text = data.source
                cell.myImage.kf.indicatorType = .activity
                cell.myImage.kf.setImage(with: URL(string: data.image ?? ""))
            }
    
                return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            if let data = data[indexPath.row] as? Article{
                vc.urlString = data.url ?? ""
                vc.titleArticle = data.title ?? ""
                vc.source = data.source?.name ?? ""
                vc.image = data.urlToImage ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }

}
