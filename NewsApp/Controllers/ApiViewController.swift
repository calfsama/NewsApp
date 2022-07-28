//
//  ApiViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 28/07/22.
//

import UIKit
//import Kingfisher


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class ApiViewController: UIViewController{
    
        let network = Network()
        var news: Articles?
        private var timer: Timer?
        
        
        @IBOutlet weak var table: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            navigationController?.navigationBar.prefersLargeTitles = true
            table.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
            table.delegate = self
            table.dataSource = self
          
    
            
            let urlString = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=5ed9b9eb9b7746b8a925c87ab583ccfa"
   
            network.request(urlString: urlString) { [weak self] (result) in
                switch result {
                case .success(let response):
                    self?.news = response
                    self?.table.reloadData()
                case .failure(let error):
                    print("error", error)
                }
            }
        }
    }

    extension ApiViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return news?.articles?.count ?? 0
        }
        
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
            let article = news?.articles?[indexPath.row]
            cell.myLabel.text = article?.title
            cell.sources.text = article?.source?.name
            cell.myImage.contentMode = .scaleAspectFill
            //let defaultLink = "https://www.reuters.com"
            //let completeLink = defaultLink + (article?.urlToImage)!
            cell.myImage.downloaded(from: (article?.urlToImage)!)
            //cell.myImage.image = UIImage(named: (article?.urlToImage)! )
            return cell
        }
    
    }

