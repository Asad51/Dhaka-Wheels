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
        // Console Logger
        let osLogger = DDOSLogger.sharedInstance
        osLogger.logFormatter = DWConsoleLogFormatter()
        DDLog.add(osLogger, with: .all)

        // File Logger
        guard let docDirUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else {
            print("Error: Document dir could not be retrieved, file logging won't work.")
            DWLogError("Error: Document dir could not be retrieved, file logging won't work.")
            return
        }

        let logFileManager = DDLogFileManagerDefault(logsDirectory: docDirUrl.path)
        let fileLogger = DDFileLogger(logFileManager: logFileManager)

        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.maximumFileSize = 20 * 1024 * 1024 // 20 MB
        fileLogger.logFileManager.maximumNumberOfLogFiles = 5
        fileLogger.logFileManager.logFilesDiskQuota = 100 * 1024 * 1024 // 100 MB
        fileLogger.logFormatter = DWFileLogFormatter()

        // Currently we do not need file logger
        // DDLog.add(fileLogger, with: .all)
    }
}
