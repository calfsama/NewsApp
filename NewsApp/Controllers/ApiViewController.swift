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
    @IBOutlet weak var table: UITableView!
    let network = NetworkService()
    var data: [Any] = []
    var currentPage : Int = 0
    var isLoadingList : Bool = false
    var news = [News]()
    var titleName: String = ""
    var type: String = ""
    var nameOfTitle: String = ""
    //var page: Int = 1
    var key: String = "5ed9b9eb9b7746b8a925c87ab583ccfa"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        title = nameOfTitle
        table.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        navigationItem.largeTitleDisplayMode = .never
        table.isSkeletonable = true
        table.showAnimatedGradientSkeleton()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if titleName == "" || type == "" {
            loadArticles()
        }else {
            fetchFromApi()
        }
    }
    
    func fetchFromApi(){
        self.network.fetchCategory(catName: self.titleName.lowercased(), kind: self.type,apiKey: self.key, page: currentPage) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                guard let articles = response.articles else {return}
                self.data = articles
                self.table.reloadData()
                self.table.stopSkeletonAnimation()
                self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
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
            data = news
            table.reloadData()
            self.table.stopSkeletonAnimation()
            self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        }catch {
            print("Error fetching data from context \(error)")
        }
    }
//    func getListFromServer(_ pageNumber: Int) {
//            self.isLoadingList = false
//            self.table.reloadData()
//        }
//
//            func loadMoreItemsForList() {
//                 currentPage += 1
//                 getListFromServer(currentPage)
//             }
//
//            func scrollViewDidScroll(_ scrollView: UIScrollView) {
//                 if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height) && !isLoadingList) {
//                     self.isLoadingList = true
//                     self.loadMoreItemsForList()
//             }
//        }
}


extension ApiViewController: UITableViewDelegate, SkeletonTableViewDataSource  {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
        else if let data = data[indexPath.row] as? News{
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
        else if let data = data[indexPath.row] as? News{
            vc.urlString = data.url ?? ""
            vc.titleArticle = data.title ?? ""
            vc.source = data.source ?? ""
            vc.image = data.image ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let data = data[indexPath.row] as? News {
            if editingStyle == .delete {
                table.beginUpdates()
                self.context.delete(data)
                self.data.remove(at: indexPath.row)
                table.deleteRows(at: [indexPath], with: .fade)
                do {
                    try context.save()
                }
                catch {
                    print("Error\(error)")
                }
                table.endUpdates()
            }
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 {
            currentPage += 1
            print(currentPage)
            fetchFromApi()
        }
    }
}
