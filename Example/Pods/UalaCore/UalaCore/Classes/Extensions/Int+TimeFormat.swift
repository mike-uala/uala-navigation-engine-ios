//
//  Int+TimeFormat.swift
//  UalaCore
//
//  Created by Juan Gallarza on 25/11/20.
//

import Foundation

public extension Int {
    func getMinutesAndSeconds() -> (String) {
        let minutes = self / 60
        let seconds = self - minutes * 60
        let secondString = seconds < 10 ? "0" + seconds.description : seconds.description
        return minutes.description + ":" + secondString
    }
}
