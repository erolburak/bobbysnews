//
//  SourceDB+Extension.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

public extension SourceDB {
    // MARK: - Lifecycles

    @discardableResult
    convenience init(from api: SourceAPI) {
        self.init(context: PersistenceController.shared.backgroundContext)
        name = api.name
        url = api.url
    }
}
