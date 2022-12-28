//
//  FixtureDetailTVC.swift
//  FootballApplication
//
//  Created by Mehmet Baturay Yasar on 26/12/2022.
//

import UIKit

class FixtureDetailTVC: UITableViewCell {
    
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var stadiumLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayImage: UIImageView!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    var response1: Response?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI() {
        backView.makeShadow()
        homeImage.makeRounded()
        awayImage.makeRounded()
    }
    
    func configureUI(response:Response?) {
        stadiumLabel.text = response?.fixture?.venue?.name ?? ""
        let date = response?.fixture?.date ?? ""
        dateLabel.text = date.getDate()?.convertToString(format: "yyyy-MM-dd HH:mm")
        
        if let home = response?.score?.fulltime?.home,
           let away = response?.score?.fulltime?.away {
            scoreLabel.text = "\(home) - \(away)"
        }else {scoreLabel.text = "# - #"}
        homeLabel.text = response?.teams?.home?.name
        awayLabel.text = response?.teams?.away?.name
        if let homeImageUrl = URL(string: response?.teams?.home?.logo ?? ""),
           let awayImageUrl = URL(string: response?.teams?.away?.logo ?? "") {
            homeImage.setImage(url: homeImageUrl)
            awayImage.setImage(url: awayImageUrl)
        }
        weekLabel.text = "\(response?.league?.round?.components(separatedBy: "-").last ?? ""). Week"
        homeLabel.textColor = response?.teams?.home?.winner == true ? UIColor(hexString: "007500") : .none
        awayLabel.textColor = response?.teams?.away?.winner == true ? UIColor(hexString: "007500") : .none
        
        homeLabel.font = response?.teams?.home?.winner == true ? UIFont(name: "OpenSans-SemiBold", size: 14) : UIFont.systemFont(ofSize: 14)
        awayLabel.font = response?.teams?.away?.winner == true ? UIFont(name: "OpenSans-SemiBold", size: 14) : UIFont.systemFont(ofSize: 14)
//        if == true  {
//            homeLabel.textColor = .green
//            awayLabel.textColor = .none
//        }else if response?.teams?.away?.winner == true {
//            awayLabel.textColor = .green
//            homeLabel.textColor = .none
//        }else {
//            homeLabel.textColor = .none
//            awayLabel.textColor = .none
//        }
        
    }
    
}
