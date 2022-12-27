//
//  Ext+URL.swift
//  aTrip
//
//  Created by Mehmet Baturay Yasar on 10/12/2022.
//

import Foundation
import Moya

extension Encodable {
    
    var urlEncodedQueryString: Task {
        dictionary.urlEncodeQueryString
    }

    var dictionary: [String: Any] {
        let decoder = JSONEncoder()
        decoder.dateEncodingStrategy = .iso8601
        guard let data = try? decoder.encode(self) else {
            return [:]
        }
        let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return dict ?? [:]
    }
    
}

extension Dictionary {
    public var urlEncodeQueryString : Task {
        let parameters = self.compactMapValues({ $0 }) as! [String: Any]
        return Task.requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    
    public var urlEncodeDefault: Task {
        let parameters = self.compactMapValues({ $0 }) as! [String: Any]
        return Task.requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var urlEncodedQueryStringWithLiteralBool : Task {
        let parameters = self.compactMapValues({ $0 }) as! [String: Any]
        return Task.requestParameters(parameters: parameters, encoding: URLEncoding(destination: .queryString, boolEncoding: .literal))
    }
}
