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
    
    
    @IBOutlet var myImage: UIImageView!
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var sources: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.addSubview(myImage)
        contentView.addSubview(myLabel)
        contentView.addSubview(sources)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
