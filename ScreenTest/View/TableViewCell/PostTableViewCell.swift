//
//  PostTableViewCell.swift
//  ScreenTest
//
//  Created by Harshad Medisage on 20/02/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!

    var modelUser : PostFavourite?{
        didSet{
            setUIConfiguration()
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
    
    func setUIConfiguration(){
        lblTitle.text = modelUser?.title
        lblTitle.textColor = .black
        lblTitle.font = UIFont(name: "Helvetica Neue Bold", size: 16)
        lblBody.text = modelUser?.body
        lblBody.textColor = .darkGray
    }
    
}
