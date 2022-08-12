//
//  BookmarksViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 29/07/22.
//

import UIKit
import CoreData

class BookmarksViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    var news = [News]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        loadArticles()
    }
    
    
    
    func loadArticles() {
        let request: NSFetchRequest <News> = News.fetchRequest()
        do {
            news = try context.fetch(request)
            for i in news{
                print(i.title)
            }
            print(news)
        }catch {
            print("Error fetching data from context \(error)")
        }
    }
    

}

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        let titleArticle = self.news[indexPath.row]
        cell.myLabel.text = titleArticle.title
        cell.sources.text = titleArticle.source
        cell.myImage.kf.setImage(with: URL(string: titleArticle.image ?? ""))
        return cell
    }
    
}
