
//
//  ViewController.swift
//  CustomCells
//
//  Created by Tomiris Negmatova on 25/07/22.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    
    var groups: [Models] = [Models(imageName: "4", title: "The company now expects to spend between $6 billion and $8 billion this year aThe company now expects to spend between $6 billion and $8 billion this year a The company now expects to spend between $6 billion and $8 billion this year a", source: "ABC News"),
                            Models(imageName: "5", title: "By David Shepardson WASHINGTON (Reuters) -   The U.S. Energy Department on Monday announced i", source: "BBC"),
                            Models(imageName: "6", title: "Replying to Investigations Editor Michael Siconolfi", source: "Daile Newsc")
    ]
    
    
    
    @IBOutlet var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        table.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        
    }
}

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        let group = groups[indexPath.row]
        cell.myLabel.text = group.title
        cell.myImage.image = UIImage(named: group.imageName)
        cell.sources.text = group.source
        return cell
    }
}

