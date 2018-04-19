//
//  Date+String.swift
//  Team4Bootcamp
//
//  Created by a.portela.rodrigues on 06/04/18.
//  Copyright © 2018 alessandra.l.pereira. All rights reserved.
//

import Foundation

extension Date {
    
    static func getDateFromString(dateString: String) -> Date? {
        if dateString == "" {
            return nil
        }
        let dates = dateString.split(separator: "-")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        guard let movieDate = formatter.date(from: "\(dates[0])/\(dates[1])/\(dates[2])") else {
            return Date()
        }
        return movieDate
    }
}
