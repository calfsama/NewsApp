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
    var pageNumber : Int = 1
    var isLoadingList : Bool = false
    var news = [News]()
    var articles: Articles?
    var titleName: String = ""
    var type: String = ""
    var nameOfTitle: String = ""
    var page: String = ""
    var searchText: String = ""
    var key: String = "8daa6dab2df841e98b029ecbae2af259"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        title = nameOfTitle
        table?.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        table?.delegate = self
        table?.dataSource = self
        navigationItem.largeTitleDisplayMode = .always
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table?.isSkeletonable = true
        table?.showAnimatedGradientSkeleton()
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
                self.pageNumber = self.articles?.totalResults ?? 2
                self.data.append(contentsOf: articles)
                self.table?.reloadData()
                self.table?.stopSkeletonAnimation()
                self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
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
                 self?.data = articles
                 self?.table?.reloadData()
                 self?.table?.stopSkeletonAnimation()
                 self?.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
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
                self.data = articles
                self.table.reloadData()
                self.table?.stopSkeletonAnimation()
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
            table?.reloadData()
            self.table?.stopSkeletonAnimation()
            self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
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
        return 10
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.table.bounds.size.width, height: self.table.bounds.size.height))
        if data.count == 0 {
            emptyLabel.text = "No Bookmarks"
            emptyLabel.textColor = .gray
            emptyLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
            emptyLabel.textAlignment = NSTextAlignment.center
            self.table.backgroundView = emptyLabel
            self.table.separatorStyle = .none
            return 0
        }
        else {
            emptyLabel.text = ""
            self.table.backgroundView = emptyLabel
            self.table.separatorStyle = .none
            return data.count
        }
            
    }
 
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return  TableViewCell.identifier
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == data.count - 1 && page != "" && pageNumber > 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "loading")
            return cell!
        }
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
        else if let data = data[indexPath.row] as? News {
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
//            page += 1
            print(pageNumber)
//            fetchFromApi()
            for i in 1...5 {
                pageNumber+=1
                fetchFromApi()
                
            }
        }
    }
}
