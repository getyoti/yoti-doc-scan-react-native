//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

import YotiSDKDesign

enum SpacingMode: String, Decodable {
    case compact
    case regular
    case relaxed
}

extension YotiSDKSpacingMode {
    init(_ mode: SpacingMode) {
        switch mode {
            case .compact:
                self = .compact
            case .regular:
                self = .regular
            case .relaxed:
                self = .relaxed
        }
    }
}
