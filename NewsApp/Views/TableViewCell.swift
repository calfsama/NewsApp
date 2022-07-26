//
//  TableViewCell.swift
//  CustomCells
//
//  Created by Tomiris Negmatova on 25/07/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    
//    public func configure(with title: String, imageName: String) {
//        myLabel.text = title
//        myImage.image = UIImage(systemName: imageName)
//    }
//    public func configure(with title: String, imageName: String) {
//  //        myLabel.text = title
//  //        myImage.image = UIImage(systemName: imageName)
  //    }
    
    
    
    @IBOutlet var myImage: UIImageView!
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var sources: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
