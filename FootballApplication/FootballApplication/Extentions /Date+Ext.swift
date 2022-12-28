//
//  Ext_.swift
//  FootballApplication
//
//  Created by Mehmet Baturay Yasar on 26/12/2022.
//

import Foundation

extension Date {
    func convertToString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateString = formatter.string(from: self)
        return dateString
    }
}
