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
        backView.makeShadow()
        homeImage.makeCornerRadius(radius: homeImage.frame.size.width / 2)
        awayImage.makeCornerRadius(radius: awayImage.frame.size.width / 2)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func reloadTableView() {
        DispatchQueue.main.async {
            self.reloadTableView()
        }
    }
    
    func getDate(stringDate:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: stringDate) // replace Date String
    }
    
    // #00FF00
    //    2022-08-07T18:45:00+00:00
    //    yyyy-MM-dd'T'HH:mm:ss
    
    func configureUI(response:Response?) {
        stadiumLabel.text = response?.fixture?.venue?.name ?? ""
        dateLabel.text = getDate(stringDate: response?.fixture?.date ?? "")?.convertToString(format: "yyyy-MM-dd HH:mm")
        
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

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
