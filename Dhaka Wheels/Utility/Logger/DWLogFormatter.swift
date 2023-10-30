//
//  DWLogFormatter.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 30/10/23.
//

import CocoaLumberjackSwift
import Foundation

/// Provides a label for Log Type, if applicable. Currently, it provides label for Error & Warning, and emptry string for the rest.
/// - Parameter logMsg: Log Message object of CocoaLumberjack
/// - Returns: label or empty string depending on log level
private func getLogTypeLabel(_ logMsg: DDLogMessage) -> String {
    switch logMsg.flag {
        case .error:
            return "Error! "
        case .warning:
            return "Warning: "
        default:
            return ""
    }
}

/// Processes log message and returns parts of log messages
/// - Parameter logMessage: Log Message object of CocoaLumberjack
/// - Returns: A tuple of (logType, queueLabel, msg, fileName, methodName, lineNo), where
///         - *logType*: Log type label
///         - *queueLabel:* Queue name
///         - *msg*: Log message
///         - *fileName*: The file name where the log is generated from
///         - *methodName*: The method name where the log is generated from
///         - *lineNo*: The line number where the log is generated from
private func processLogMessage(_ logMessage: DDLogMessage) -> (String, String, String, String, String, UInt) {
    let logType = getLogTypeLabel(logMessage)

    // Queue name
    var queueLabel = ""
    if !logMessage.queueLabel.isEmpty {
        queueLabel = "[Queue: \(logMessage.queueLabel)] "
    }

    let msg = logMessage.message
    var fileName = "#fileName#"
    var methodName = "#funcName#"
    var lineNo: UInt = 0

    fileName = logMessage.fileName

    if let funcName = logMessage.function {
        methodName = funcName
    }
    lineNo = logMessage.line

    return (logType, queueLabel, msg, fileName, methodName, lineNo)
}

/// Log formatter class for Console Logger
class DWConsoleLogFormatter: NSObject, DDLogFormatter {
    func format(message logMessage: DDLogMessage) -> String? {
        let (logType, queueLabel, msg, fileName, methodName, lineNo) = processLogMessage(logMessage)

        return String("[TID:\(logMessage.threadID)] \(queueLabel)[\(fileName)::\(methodName)::line \(lineNo)] \(logType)\(msg)")
    }
}
