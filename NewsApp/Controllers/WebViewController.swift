//
//  WebViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 29/07/22.
//

import UIKit
import WebKit
import CoreData
import SwiftUI

class WebViewController: UIViewController {
    @IBOutlet weak var bookmarks: UIBarButtonItem!
    let webView = WKWebView() 
    var article: Article?
    var arc: String = ""
    var news = [News]()
    var urlString: String = ""
    var titleArticle: String = ""
    var source: String = ""
    var image: String = ""
    var toggleButtonChecked = true
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        configureConstraints()
        webView.translatesAutoresizingMaskIntoConstraints = false

        guard let url = URL(string: urlString) else {
            return
        }
        webView.load(URLRequest(url: url))

        loadArticles()
    }

    
    func configureConstraints() {
        
        
        NSLayoutConstraint.activate([
        
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        
        ])
    }
    
    @IBAction func addBookmarks(_ sender: UIBarButtonItem){
        
        
        if toggleButtonChecked == false {
            toggleButtonChecked = true
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark.fill")
            save()
           
        }
        else if toggleButtonChecked == true {
            toggleButtonChecked = false
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark")
           
        }
    
    }

    
    
     func save() {
         
         let news = News(context: self.context)
         news.title = titleArticle
         news.source = source
         news.image = image

         self.news.append(news)
         print("ischecked")

        do {
            try context.save()
        }catch {
            print("Error saving context \(error)")
        }

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
