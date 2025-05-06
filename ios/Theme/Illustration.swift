//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

import YotiSDKDesign

struct Illustration: Decodable {
    var bundleIdentifier: String?
    var name: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let bundleIdentifier = try container.decodeIfPresent(String.self, forKey: .bundleIdentifier), !bundleIdentifier.isEmpty {
            self.bundleIdentifier = bundleIdentifier
        } else if let bundleIdentifier = Bundle.main.bundleIdentifier, !bundleIdentifier.isEmpty {
            self.bundleIdentifier = bundleIdentifier
        }
        if let name = try container.decodeIfPresent(String.self, forKey: .name), !name.isEmpty {
            self.name = name
        }
    }

    private enum CodingKeys: String, CodingKey {
        case bundleIdentifier = "bundle_identifier"
        case name
    }
}

extension YotiSDKIllustration {
    init?(_ illustration: Illustration) {
        guard let bundleIdentifier = illustration.bundleIdentifier, let name = illustration.name else {
            return nil
        }
        self.init(bundleIdentifier: bundleIdentifier, name: name)
    }
}
