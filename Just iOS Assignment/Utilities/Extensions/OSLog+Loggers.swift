//
//  OSLog+Loggers.swift
//  Just iOS Assignment
//
//  Created by Ghalaab on 11/10/2021.
//

import Foundation
import os.log

extension OSLog {
    private static let subsystem = Bundle.main.bundleIdentifier!
    static let modelsLogger = OSLog(subsystem: OSLog.subsystem, category: "Models")
}
