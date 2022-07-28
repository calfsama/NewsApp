//
//  WebViewController.swift
//  NewsApp
//
//  Created by Tomiris Negmatova on 29/07/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    let webView = WKWebView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        configureConstraints()
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let url = URL(string: "https://www.theverge.com/2022/7/12/23205066/texas-heat-curtails-bitcoin-mining-energy-demand-electricity-grid") else {
            return
        }
        webView.load(URLRequest(url: url))

        
    }
    
    func configureConstraints() {
        
        
        NSLayoutConstraint.activate([
        
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        
        ])
    }

}
