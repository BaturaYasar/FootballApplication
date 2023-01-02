//
//  TeamDetailVC.swift
//  FootballApplication
//
//  Created by Mehmet Baturay Yasar on 28/12/2022.
//

import UIKit

class TeamDetailVC: UIViewController {

    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var lostView: UIView!
    @IBOutlet weak var drawView: UIView!
    @IBOutlet weak var wonView: UIView!
    @IBOutlet weak var gamesView: UIView!
    
    @IBOutlet weak var lostLabel: UILabel!
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var wonLabel: UILabel!
    @IBOutlet weak var totalGamesLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var foundedLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var stadiumCapacityLabel: UILabel!
    @IBOutlet weak var stadiumLabel: UILabel!
    
    var teamID: Int?

    var teamDetailResponse: TeamDetailResponse?
    var teamResponse: FixtureListResponse?
    var teamFixture: [Response]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTeamStatistics()
        setupCollectionView()
        filterData()
    }
    
    func setupUI() {
        guard let response = teamDetailResponse?.response?.first else {return}
        if let teamLogoURL = URL(string: response.team?.logo ?? "") {
            teamImage.setImage(url: teamLogoURL)
        }
        teamNameLabel.text = response.team?.name
        countryLabel.text = response.team?.country
        stadiumLabel.text = response.venue?.name
        stadiumCapacityLabel.text = "\(response.venue?.capacity ?? 0)"
        addressLabel.text = response.venue?.address
        cityLabel.text = response.venue?.city
        foundedLabel.text = "\(response.team?.founded ?? 0)"
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let uinib = UINib(nibName: DetailFixtureCVC.identifier, bundle: nil)
        collectionView.register(uinib, forCellWithReuseIdentifier: DetailFixtureCVC.identifier)
    }
    
    fileprivate func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func getTeamStatistics() {
        guard let teamID = teamID else {return}
        let request = TeamStatisticRequest(id: teamID)
        NetworkManager.shared.getTeamStatistic(request: request) { result in
            switch result {
            case .success(let response):
                self.teamDetailResponse = response
                self.setupUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func filterData() {
        if let teamResponse = teamResponse {
            let filteredTeam = teamResponse.response?.filter({($0.teams?.home?.id == self.teamID) || ($0.teams?.away?.id == self.teamID)})
            self.teamFixture = filteredTeam
            reloadCollectionView()
        }
    }
}

//MARK: - @IBActions -
extension TeamDetailVC {
   
    @IBAction func aboutButtonTapped(_ sender: Any) {
        aboutView.isHidden = false
        collectionView.isHidden = true
    }
    
    @IBAction func fixtureButtonTapped(_ sender: Any) {
        collectionView.isHidden = false
        aboutView.isHidden = true
    }
    
}

extension TeamDetailVC: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamFixture?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailFixtureCVC.identifier, for: indexPath) as! DetailFixtureCVC
        cell.configureUI(response: teamFixture?[indexPath.row])
        return cell
    }
    
    
}

extension TeamDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width)
        return CGSize(width: width, height: 50)
    }
}
