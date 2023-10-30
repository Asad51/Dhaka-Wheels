//
//  Logging.swift
//  Dhaka Wheels
//
//  Created by Md. Asadul Islam on 30/10/23.
//

// This is a collection of wrapper functions over CocoaLumberjackSwift logging framework.
// The objective of this wrapper is to enable parameterless logging method call, so that we don't have to write `DWLogVerbose("")` and just can write `DWLogVerbose()`.

import CocoaLumberjackSwift

/// Logging method for error messages.
///
/// Usage:
///
///     DWLogError("error message")
/// - Note: Do not add filename, method name or line number in log message. They will be automatically inserted.
/// - Parameters:
///   - message: The error message
///   - level: Log level.
///   - context: Logging context.
///   - file: Log originating file name.
///   - function: Log originating function name.
///   - line: Log originating line number.
///   - tag: Log tag.
///   - async: asynchronous logging option.
///   - ddlog: DDLog instance reference.
func DWLogError(_ message: Any, level: DDLogLevel = .error, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: Any? = nil, asynchronous async: Bool = false, ddlog: DDLog = .sharedInstance) {

    

    CocoaLumberjackSwift.DDLogError(message, level: level, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}

/// Logging method for warning messages.
///
/// Usage:
///
///     DWLogWarn("warning message")
/// - Note: Do not add filename, method name or line number in log message. They will be automatically inserted.
/// - Parameters:
///   - message: The warning message
///   - level: Log level.
///   - context: Logging context.
///   - file: Log originating file name.
///   - function: Log originating function name.
///   - line: Log originating line number.
///   - tag: Log tag.
///   - async: asynchronous logging option.
///   - ddlog: DDLog instance reference.
func DWLogWarn(_ message: Any, level: DDLogLevel = .warning, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: Any? = nil, asynchronous async: Bool = asyncLoggingEnabled, ddlog: DDLog = .sharedInstance) {
    CocoaLumberjackSwift.DDLogWarn(message, level: level, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}

/// Logging method for info messages.
///
/// Usage:
///
///     DWLogInfo()
///     DWLogInfo("info message")
/// - Note: Do not add filename, method name or line number in log message. They will be automatically inserted.
/// - Parameters:
///   - message: The info message
///   - level: Log level. 
///   - context: Logging context. 
///   - file: Log originating file name. 
///   - function: Log originating function name. 
///   - line: Log originating line number. 
///   - tag: Log tag. 
///   - async: asynchronous logging option. 
///   - ddlog: DDLog instance reference. 
func DWLogInfo(_ message: Any = "", level: DDLogLevel = .info, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: Any? = nil, asynchronous async: Bool = asyncLoggingEnabled, ddlog: DDLog = .sharedInstance) {
    CocoaLumberjackSwift.DDLogInfo(message, level: level, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}

/// Logging method for debug messages.
///
/// Usage:
///
///     DWLogDebug()
///     DWLogDebug("debug message")
/// - Note: Do not add filename, method name or line number in log message. They will be automatically inserted.
/// - Parameters:
///   - message: The debug message
///   - level: Log level. 
///   - context: Logging context. 
///   - file: Log originating file name. 
///   - function: Log originating function name. 
///   - line: Log originating line number. 
///   - tag: Log tag. 
///   - async: asynchronous logging option. 
///   - ddlog: DDLog instance reference. 
func DWLogDebug(_ message: Any = "", level: DDLogLevel = .debug, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: Any? = nil, asynchronous async: Bool = asyncLoggingEnabled, ddlog: DDLog = .sharedInstance) {
    CocoaLumberjackSwift.DDLogDebug(message, level: level, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}

/// Logging method for verbose messages.
///
/// Usage:
///
///     DWLogVerbose()
///     DWLogVerbose("verbose message")
/// - Note: Do not add filename, method name or line number in log message. They will be automatically inserted.
/// - Parameters:
///   - message: The verbose message
///   - level: Log level. 
///   - context: Logging context. 
///   - file: Log originating file name. 
///   - function: Log originating function name. 
///   - line: Log originating line number. 
///   - tag: Log tag. 
///   - async: asynchronous logging option. 
///   - ddlog: DDLog instance reference. 
func DWLogVerbose(_ message: Any = "", level: DDLogLevel = .verbose, context: Int = 0, file: StaticString = #file, function: StaticString = #function, line: UInt = #line, tag: Any? = nil, asynchronous async: Bool = asyncLoggingEnabled, ddlog: DDLog = .sharedInstance) {
    CocoaLumberjackSwift.DDLogVerbose(message, level: level, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}
