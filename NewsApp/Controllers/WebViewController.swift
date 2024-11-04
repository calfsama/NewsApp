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
    var news = [News]()
    var urlString: String = ""
    var titleArticle: String = ""
    var source: String = ""
    var image: String = ""
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    var commitPredicate: NSPredicate?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

 
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator()
        buttonState()
        configureConstraints()
        guard let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func indicator() {
        webView.addSubview(spinner)
        spinner.center = webView.center
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        webView.bringSubviewToFront(spinner)
    }
  
    func configureConstraints() {
        view.addSubview(webView)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    func buttonState() {
        let fetchRequest: NSFetchRequest <News> = News.fetchRequest()
        fetchRequest.predicate = commitPredicate
        commitPredicate = NSPredicate(format: "title == %@", titleArticle)
        do {
            let data = try context.fetch(fetchRequest)
            for i in data {
                if i.title == titleArticle {
                    print("\(i.title ?? "") and \(titleArticle)")
                    navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark.fill")
                }
                else if i.title == nil{
                    navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark")
                }
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
    
    @IBAction func addBookmarks(_ sender: UIBarButtonItem){
        let fetchRequest: NSFetchRequest <News> = News.fetchRequest()
        fetchRequest.predicate = commitPredicate
        commitPredicate = NSPredicate(format: "title == %@", titleArticle)
        do{
            let data = try context.fetch(fetchRequest).first
            if data == nil {
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark.fill")
                saveArticles()
            }
            else {
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark")
                deleteArticles()
            }
        }
        catch {
            print("Error\(error)")
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        spinner.stopAnimating()
    }
}

