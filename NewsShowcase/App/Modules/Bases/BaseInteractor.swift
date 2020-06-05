//
//  BaseInteractor.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

class BaseInteractor<Service: ServiceDefinable> {
    var serviceProvider: ServiceProvider<Service>?

    init() {
        serviceProvider = ServiceFactory.getServiceProvider(for: Service.self)
    }
}
