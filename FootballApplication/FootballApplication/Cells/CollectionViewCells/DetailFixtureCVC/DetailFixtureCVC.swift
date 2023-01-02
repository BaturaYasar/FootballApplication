//
//  DetailFixtureCVC.swift
//  FootballApplication
//
//  Created by Mehmet Baturay Yasar on 29/12/2022.
//

import UIKit

class DetailFixtureCVC: UICollectionViewCell {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureUI(response:Response?) {
        guard let response = response else {return}
        homeTeamLabel.text = response.teams?.home?.name
        awayTeamLabel.text = response.teams?.away?.name
        if let home = response.score?.fulltime?.home,
           let away = response.score?.fulltime?.away {
            scoreLabel.text = "\(home) - \(away)"
        }else {scoreLabel.text = "# - #"}
        homeTeamLabel.text = response.teams?.home?.name
        awayTeamLabel.text = response.teams?.away?.name
    }

}
