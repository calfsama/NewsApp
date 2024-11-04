//
//  TableViewCell.swift
//  CustomCells
//
//  Created by Tomiris Negmatova on 25/07/22.
//

import UIKit
import SkeletonView

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
        contentView.addSubview(myImage)
        contentView.addSubview(myLabel)
        contentView.addSubview(sources)
        myLabel.skeletonTextNumberOfLines = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
