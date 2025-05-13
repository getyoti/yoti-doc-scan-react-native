//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

import UIKit

enum FontDesign: String, Decodable {
    case `default`
    case rounded
    case serif
    case monospaced
}

@available(iOS 13, *)
extension UIFontDescriptor.SystemDesign {
    init(_ design: FontDesign) {
        switch design {
            case .`default`:
                self = .`default`
            case .rounded:
                self = .rounded
            case .serif:
                self = .serif
            case .monospaced:
                self = .monospaced
        }
    }
}
