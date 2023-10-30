//
//  DWLogger.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 24/10/23.
//

import CocoaLumberjackSwift
import Foundation

class DWLogger {
    static func initialize() {
        let osLogger = DDOSLogger.sharedInstance
        osLogger.logFormatter = DWConsoleLogFormatter()
        DDLog.add(osLogger, with: .all)
    }
}
