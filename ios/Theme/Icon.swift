//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

import UIKit
import YotiSDKDesign

@available(iOS 13, *)
struct Icon: Decodable {
    var bundleIdentifier: String?
    var customName: String?
    var systemName: String?
    var weight: UIImage.SymbolWeight?
    var locale: Locale?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let bundleIdentifier = try container.decodeIfPresent(String.self, forKey: .bundleIdentifier), !bundleIdentifier.isEmpty {
            self.bundleIdentifier = bundleIdentifier
        } else if let bundleIdentifier = Bundle.main.bundleIdentifier, !bundleIdentifier.isEmpty {
            self.bundleIdentifier = bundleIdentifier
        }
        if let customName = try container.decodeIfPresent(String.self, forKey: .customName), !customName.isEmpty {
            self.customName = customName
        }
        if let systemName = try container.decodeIfPresent(String.self, forKey: .systemName), !systemName.isEmpty {
            self.systemName = systemName
        }
        if let rawValue = try container.decodeIfPresent(String.self, forKey: .weight), !rawValue.isEmpty {
            let weight = SymbolWeight(rawValue: rawValue)!
            self.weight = UIImage.SymbolWeight(weight)
        }
        if let localeIdentifier = try container.decodeIfPresent(String.self, forKey: .localeIdentifier), !localeIdentifier.isEmpty {
            if localeIdentifier == "current" {
                locale = .current
            } else {
                locale = Locale(identifier: localeIdentifier)
            }
        }
    }

    private enum CodingKeys: String, CodingKey {
        case bundleIdentifier = "bundle_identifier"
        case customName = "custom_name"
        case systemName = "system_name"
        case weight
        case localeIdentifier = "locale_identifier"
    }
}

@available(iOS 13, *)
extension YotiSDKIcon {
    init?(_ icon: Icon) {
        if let bundleIdentifier = icon.bundleIdentifier, let customName = icon.customName {
            self.init(bundleIdentifier: bundleIdentifier, name: customName, weight: icon.weight, locale: icon.locale)
        } else if let systemName = icon.systemName {
            self.init(systemName: systemName, weight: icon.weight, locale: icon.locale)
        } else {
            return nil
        }
    }
}
