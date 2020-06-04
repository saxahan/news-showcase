//
//  AppConfig.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

final class AppConfig {
    static var environment: Environment!
    static var isDebug: Bool = false
    static var isMocking: Bool = false

    static func configure() {
        #if DEBUG
        isDebug = true
        isMocking = false
        #endif

        loadFromConfigFile()
    }

    private static func loadFromConfigFile() {
        let fileName: String = isDebug ? "Config-Stage" : "Config-Prod"

        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist"),
            let config = NSDictionary(contentsOfFile: path) as? [String: Any] else {
            fatalError("No defined Config plist file!")
        }

        guard let baseUrlStr = config["BaseUrl"] as? String,
            let baseUrl = URL(string: baseUrlStr),
            let apiKey = config["ApiKey"] as? String else {
                fatalError("No defined BaseUrl and ApiKey")
        }

        environment = Environment(baseUrl: baseUrl,
                                  apiKey: apiKey)

        Logger.log(.info(message: "Application has been loaded with \(fileName).plist successfully."))
        Logger.log(.info(message: "API base url: \(environment.baseUrl.absoluteString)"))
        Logger.log(.info(message: "API key: \(environment.apiKey)"))
    }
}
