//
//  Logger.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

enum Logger {
    case info(message: String)
    case error(message: String, error: Any?)

    static func log(_ case: Logger) {
        switch `case` {
        case .info(let message):
            print("🟡 \(message)")
        case .error(let message, let error):
            var items: [Any] = ["🔴 \(message)"]

            if let err = error {
                items.append(err)
            }

            print(items)
        }
    }
}

public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(output, terminator: terminator)
    #else
        // You can write them to a file,
        // or sent them to a server in order to keep tracking for all cases in production.
    #endif
}
