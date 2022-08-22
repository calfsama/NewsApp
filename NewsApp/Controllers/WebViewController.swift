//
//  WebViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 29/07/22.
//

import UIKit
import WebKit
import CoreData

class WebViewController: UIViewController {
    @IBOutlet weak var bookmarks: UIBarButtonItem!
    let webView = WKWebView() 
    var article: Article?
    var news = [News]()
    var urlString: String = ""
    var titleArticle: String = ""
    var source: String = ""
    var image: String = ""
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    var toggleButtonChecked = true
    var commitPredicate: NSPredicate?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        configureConstraints()
        webView.addSubview(spinner)
//        spinner = UIActivityIndicatorView(style: .gray)
        spinner.center = webView.center
        webView.bringSubviewToFront(spinner)
        webView.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        guard let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
        if webView.load(URLRequest(url: url)) != nil {
            spinner.stopAnimating()
        }
        let fetchRequest: NSFetchRequest <News> = News.fetchRequest()
        fetchRequest.predicate = commitPredicate
        commitPredicate = NSPredicate(format: "title == %@", titleArticle)
  
        do {
            let data = try context.fetch(fetchRequest)
            print(data)
            for i in data {
                if i.title == titleArticle {
                    print(i)
                    print(titleArticle)
                    navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark.fill")
                }
                else if i == nil{
                    print(i)
                    navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark")
                }
            }
        }
        catch {
            print("Error\(error)")
        }
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
        let fetchRequest: NSFetchRequest <News> = News.fetchRequest()
        fetchRequest.predicate = commitPredicate
        commitPredicate = NSPredicate(format: "title == %@", titleArticle)
        
        do{
            let data = try context.fetch(fetchRequest).first
            print(data)
            if data == nil {
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark.fill")
                saveArticles()
            }
            else {
                print("Object has been deleted")
                print(titleArticle)
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark")
                deleteArticles()
            }
        }
        catch {
            print("Error\(error)")
        }
    }

     func saveArticles() {
         let news = News(context: self.context)
         news.title = titleArticle
         news.source = source
         news.image = image
         news.url = urlString
         self.news.append(news)
         print("ischecked")
        do {
            try context.save()
        }catch {
            print("Error saving context \(error)")
        }
    }
    
    func deleteArticles() {
        let object: NSFetchRequest <News> = News.fetchRequest()
        object.predicate = commitPredicate
        commitPredicate = NSPredicate(format: "title == %@", titleArticle)
        do {
            let object = try context.fetch(object)
            print(object)
            for i in object {
                if i.title == titleArticle {
                    context.delete(i)
                }
                do {
                    try context.save()
                }catch {
                    print("Error \(error)")
                }
            }
        }
        catch {
            print("Error \(error)")
        }
    }
}

