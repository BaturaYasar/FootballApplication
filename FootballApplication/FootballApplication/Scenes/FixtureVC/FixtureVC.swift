//
//  FixtureVC.swift
//  FootballApplication
//
//  Created by Mehmet Baturay Yasar on 26/12/2022.
//

import UIKit

class FixtureVC: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var fixtureListResponse: FixtureListResponse?
    var picker = UIPickerView()
    var seasonArray = [2022, 2021, 2020, 2019]
    var fixtureDictionary = [String:[Response]]()
    var fixtureSection: [FixtureSectionModel] = []
    var leagueID: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFixtureList(season: seasonArray.first ?? 2022) // 2022
        setupTableView()
        setupPickerView()
    }
    
    func setupPickerView() {
        textField.inputView = picker
        picker.dataSource = self
        picker.delegate = self
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let uinib = UINib(nibName: FixtureDetailTVC.identifier, bundle: nil)
        tableView.register(uinib, forCellReuseIdentifier: FixtureDetailTVC.identifier)
    }
    
    fileprivate func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func getFixtureList(season: Int) {
        guard let leagueID = leagueID else {return}
        let request = FixtureListRequest.init(season: season, league: leagueID)
        NetworkManager.shared.getFixtureList(request: request) { result in
            switch result {
            case .success(let model):
                self.fixtureListResponse = model
                self.fixtureSection.removeAll()
                if let response = self.fixtureListResponse?.response {
                    self.fixtureDictionary = Dictionary(grouping: response, by: {$0.league?.round?.components(separatedBy: "- ").last ?? ""})
                    self.fixtureDictionary.forEach { item in
                        let tempFixtureSectionModel = FixtureSectionModel(week: Int(item.key) ?? 0, fixtureItem: item.value)
                        self.fixtureSection.append(tempFixtureSectionModel)
                    }
                }
                self.fixtureSection = self.fixtureSection.sorted(by: {$0.week < $1.week})
                self.reloadTableView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func toHomeTeamDetail(_ sender:UIButton) {
        let touchedHomeTeam = fixtureListResponse?.response?.first(where: {$0.teams?.home?.id == sender.tag})
        let vc = TeamDetailVC()
        vc.teamResponse = fixtureListResponse
        vc.teamID = sender.tag
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func toAwayTeamDetail(_ sender:UIButton) {
        let touchedAwayTeam = fixtureListResponse?.response?.first(where: {$0.teams?.away?.id == sender.tag})
        let vc = TeamDetailVC()
        vc.teamResponse = fixtureListResponse
        vc.teamID = sender.tag
        navigationController?.pushViewController(vc, animated: true)

    }
    
}

extension FixtureVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fixtureSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixtureSection[section].fixtureItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FixtureDetailTVC.identifier, for: indexPath) as! FixtureDetailTVC
        let model = fixtureSection[indexPath.section].fixtureItem[indexPath.row]
        cell.configureUI(response: model)
        cell.homeButtonOutlet.tag = model.teams?.home?.id ?? 0
        cell.awayButtonOutlet.tag = model.teams?.away?.id ?? 0
        cell.homeButtonOutlet.addTarget(self, action:#selector(toHomeTeamDetail(_:)), for: .touchUpInside)
        cell.awayButtonOutlet.addTarget(self, action:#selector(toAwayTeamDetail(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedMatch = fixtureListResponse?.response?[indexPath.row] {
            let vc = BottomSheetDetailVC()
            vc.fixtureResponse = selectedMatch
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(fixtureSection[section].week). Week"
    }
    
    
}

extension FixtureVC: UITableViewDelegate {
    
}


extension FixtureVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return seasonArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(seasonArray[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getFixtureList(season: seasonArray[row])
        scrollToFirstRow()
        textField.text = "Season \(seasonArray[row])"
        view.endEditing(true)
    }
    
    
}

struct FixtureSectionModel {
    var week: Int
    var fixtureItem: [Response]
}
