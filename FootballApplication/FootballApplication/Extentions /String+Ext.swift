//
//  String+Ext.swift
//  FootballApplication
//
//  Created by Mehmet Baturay Yasar on 28/12/2022.
//

import Foundation

extension String {
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
    }
}
