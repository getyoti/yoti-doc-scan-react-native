//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

struct FileConfiguration: Decodable {
    var bundleIdentifier: String?
    var filename: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let bundleIdentifier = try container.decodeIfPresent(String.self, forKey: .bundleIdentifier), !bundleIdentifier.isEmpty {
            self.bundleIdentifier = bundleIdentifier
        } else if let bundleIdentifier = Bundle.main.bundleIdentifier, !bundleIdentifier.isEmpty {
            self.bundleIdentifier = bundleIdentifier
        }
        if let filename = try container.decodeIfPresent(String.self, forKey: .filename), !filename.isEmpty {
            self.filename = filename
        }
    }

    private enum CodingKeys: String, CodingKey {
        case bundleIdentifier = "bundle_identifier"
        case filename
    }
}
