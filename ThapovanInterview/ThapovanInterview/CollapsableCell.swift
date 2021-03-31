//
//  CollapsableCell.swift
//  Thapovan
//
//  Created by E5000416 on 31/03/21.
//

import UIKit

class CollapsableCell: UITableViewCell {

    @IBOutlet weak var commentLabel:UILabel!
    @IBOutlet weak var arrow:UIButton!
    @IBOutlet weak var body:UIView!

    static let identifier = "CollapsableCell"
    static func nib()-> UINib {
        return UINib(nibName: "CollapsableCell", bundle: nil)
    }
    public func configure(with comments:[CommentObject],indexPath:IndexPath) {
        if indexPath.row == 0 {
            //header
            let comment = comments[indexPath.section]
            body.backgroundColor = .lightGray
            arrow.isHidden = false
            commentLabel.text = comment.comment?.capitalized
            arrow.isSelected = comment.isOpen
        } else {
            let replay = comments[indexPath.section].replies[indexPath.row-1]
            body.backgroundColor = .systemBackground
            arrow.isHidden = true
            commentLabel.text = replay.capitalized
        }
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
