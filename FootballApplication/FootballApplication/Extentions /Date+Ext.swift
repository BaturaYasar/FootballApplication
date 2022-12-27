//
//  Ext_.swift
//  FootballApplication
//
//  Created by Mehmet Baturay Yasar on 26/12/2022.
//

import Foundation

extension Date {
    func getDateFromTimeStamp(timeStamp : Double) -> String {
        
        let date = NSDate(timeIntervalSince1970: timeStamp / 1000)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd MMM YY, hh:mm a"
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
}

extension Date {
    
    
    static func getFormatDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date? = dateFormatterGet.date(from: "2018-02-01T19:10:04+00:00")
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }
}

//extension Double {
//    func getDateStringFromUnixTime(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = dateStyle
//        dateFormatter.timeStyle = timeStyle
//        return dateFormatter.string(from: Date(timeIntervalSince1970: <#T##TimeInterval#>: self))
//    }
//}

extension String {
    func toDate(_ timestamp: Any?) -> AnyObject? {
        if let any = timestamp {
            if let str = any as? NSString {
                return Date(timeIntervalSince1970: str.doubleValue) as AnyObject
            } else if let str = any as? NSNumber {
                return Date(timeIntervalSince1970: str.doubleValue) as AnyObject
            }
        }
        return nil
    }
}


extension Date {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

func convertDateFormater(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = dateFormatter.date(from: date)
    dateFormatter.dateFormat = "dd/MM/yyyy"
    return  dateFormatter.string(from: date!)
}

extension Date {
    func convertToString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateString = formatter.string(from: self)
        return dateString
    }
}

public enum Decoders {
    public static let mainDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Decoders.dateFormat
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    public static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss ZZZZZ" //2022-08-07T18:45:00+00:00
}
