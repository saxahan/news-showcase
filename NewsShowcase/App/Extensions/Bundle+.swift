//
//  Bundle+.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

extension Bundle {
    func data(for file: String) -> Data? {
        guard let filePath = Bundle.main.path(forResource: file.fileName,
                                              ofType: file.fileExtension) else {
                                                return Data()
        }

        let url = URL(fileURLWithPath: filePath)
        return try? Data(contentsOf: url)
    }
}
