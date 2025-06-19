//
//  Source+Extension.swift
//  BobbysNewsDomain
//
//  Created by Burak Erol on 26.01.24.
//

import BobbysNewsData

extension Source {
    // MARK: - Lifecycles

    init?(from db: SourceDB?) {
        guard let db else {
            return nil
        }
        self.init(
            name: db.name,
            url: db.url
        )
    }
}
