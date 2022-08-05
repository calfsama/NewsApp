//
//  ApiViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 28/07/22.
//

import UIKit
import Kingfisher
import SkeletonView


class ApiViewController: UIViewController, UIScrollViewDelegate{

        let network = NetworkService()
        var news: Articles?
        var currentPage: Int = 0
        var isLoadingList: Bool = false

        var titleName: String = ""
        var lang: String = ""
        var nameOfTitle: String = ""
        var pages: String = ""

        @IBOutlet weak var table: UITableView!

        override func viewDidLoad() {
            super.viewDidLoad()
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.backBarButtonItem?.tintColor = UIColor(named: "purple")
            table.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
            table.delegate = self
            table.dataSource = self
            title = nameOfTitle
            nameOfTitle = titleName

            table.rowHeight = UITableView.automaticDimension
            table.estimatedRowHeight = 10
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {

                self.network.fetchCategory(catName: self.titleName.lowercased(), kind: self.lang, page: self.pages, pageNumber: self.currentPage) { [weak self] (result) in
                switch result {
                case .success(let response):
                    self?.news = response
                    self?.table.reloadData()
//                    self?.loadMoreItemsForList()
                case .failure(let error):
                    print("error", error)
                }
            }
                self.table.stopSkeletonAnimation()
                self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0))

            })
        }
//    func getListFromServer(_ pageNumber: Int) {
//        self.isLoadingList = false
//        self.table.reloadData()
//    }
//
//    func loadMoreItemsForList() {
//        currentPage += 1
//        getListFromServer(currentPage)
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height) && !isLoadingList) {
//            self.isLoadingList = true
//            self.loadMoreItemsForList()
//        }
//    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        table.isSkeletonable = true
        table.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .systemIndigo), animation: nil, transition: .crossDissolve(0.25))
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
            return news?.articles?.count ?? 0
        }
    

        func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
            return  TableViewCell.identifier
        }

        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
            let article = news?.articles?[indexPath.row]
            cell.myLabel.text = article?.title
            cell.sources.text = article?.source?.name
            cell.myImage.kf.indicatorType = .activity
            cell.myImage.kf.setImage(with: URL(string: article?.urlToImage ?? ""))

            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }

