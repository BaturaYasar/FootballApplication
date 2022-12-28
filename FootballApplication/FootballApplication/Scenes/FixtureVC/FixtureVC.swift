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
    var fixtureDictionary = [[Int:Response]]()
    
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
        let request = FixtureListRequest.init(season: season, league: 203)
        NetworkManager.shared.getFixtureList(request: request) { result in
            switch result {
            case .success(let model):
                if let response = model.response {
                    for element in response {
                        print(element)
                        let week = Int(element.league?.round?.components(separatedBy: "- ").last ?? "") ?? 0
                        self.fixtureDictionary.append([week:element])
                    }
                }
                self.fixtureListResponse = model
                self.reloadTableView()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension FixtureVC: UITableViewDataSource {
  
    func numberOfSections(in tableView: UITableView) -> Int {
//        return fixtureDictionary.dictionary.keys.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixtureListResponse?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FixtureDetailTVC.identifier, for: indexPath) as! FixtureDetailTVC
        
        cell.configureUI(response: fixtureListResponse?.response?[indexPath.row])
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
