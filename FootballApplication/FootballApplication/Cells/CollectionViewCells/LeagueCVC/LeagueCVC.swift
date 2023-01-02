//
//  LeagueCVC.swift
//  FootballApplication
//
//  Created by Mehmet Baturay Yasar on 24/12/2022.
//

import UIKit

class LeagueCVC: UICollectionViewCell {

    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.makeShadow()
        labelCell.font = UIFont(name: "OpenSans-Regular", size: 17)
    }

    func configureCell(response: Response?) {
        labelCell.text = response?.league?.name ?? ""
        if let url = URL(string: response?.league?.logo ?? "") {
            imageCell.setImage(url: url)
        }else { imageCell.image = nil }
    }
}
