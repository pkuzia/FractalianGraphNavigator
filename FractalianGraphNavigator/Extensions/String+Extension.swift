import UIKit

extension String {

    static var empty: String {
        return ""
    }

    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
