//
//  ViewController.swift
//  FootballApplication
//
//  Created by Mehmet Baturay Yasar on 24/12/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var leagueArray: [Response]?
    var leagueListResponse: LeagueListResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getLeagueList()
    }
    
    fileprivate func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let uinib = UINib(nibName: LeagueCVC.identifier, bundle: nil)
        collectionView.register(uinib, forCellWithReuseIdentifier: LeagueCVC.identifier)
    }
    
    func getLeagueList() {
        NetworkManager.shared.getLeagueList(request: .init(country: "Turkey")) { result in
            switch result {
            case .success(let response):
                self.leagueArray = response.response
                self.leagueListResponse = response
                self.reloadCollectionView()
            case .failure(let failure):
                print(failure)
            }
        }
    }


}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leagueArray?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeagueCVC.identifier, for: indexPath) as! LeagueCVC
        cell.configureCell(response: leagueArray?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FixtureVC()
        vc.leagueID = leagueArray?[indexPath.row].league?.id
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width / 3)
        return CGSize(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

