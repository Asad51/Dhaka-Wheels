//
//  DWLogger.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 24/10/23.
//

import Foundation
import CocoaLumberjackSwift

class DWLogFormatter: NSObject, DDLogFormatter {
    private let dateFormatter: DateFormatter

    override init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"

        super.init()
    }

    func format(message logMessage: DDLogMessage) -> String? {
        let timestamp = dateFormatter.string(from: logMessage.timestamp)
        let logLevel = logMessage.level
        let logText = logMessage.message

        return "\(timestamp):: [\(logLevel)]: \(logText)"
    }
}

public class DWLogger {
    let logger = DDOSLogger.sharedInstance

    public init() {
        logger.logFormatter = DWLogFormatter()
        DDLog.add(logger, with: .debug)
    }
}

public func DWLogDebug(_ message: String) {
    DDLogVerbose(message)
}
