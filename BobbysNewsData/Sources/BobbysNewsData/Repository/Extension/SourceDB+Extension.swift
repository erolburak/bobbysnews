//
//  SourceDB+Extension.swift
//  BobbysNewsData
//
//  Created by Burak Erol on 26.01.24.
//

extension SourceDB {
    // MARK: - Lifecycles

    @discardableResult
    public convenience init(from api: SourceAPI) {
        self.init(context: PersistenceController.shared.backgroundContext)
        name = api.name
        url = api.url
    }
}
