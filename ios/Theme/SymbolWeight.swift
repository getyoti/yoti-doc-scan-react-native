//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

import UIKit

enum SymbolWeight: String, Decodable {
    case unspecified
    case ultraLight = "ultra_light"
    case thin
    case light
    case regular
    case medium
    case semibold
    case bold
    case heavy
    case black
}

@available(iOS 13, *)
extension UIImage.SymbolWeight {
    init(_ weight: SymbolWeight) {
        switch weight {
            case .unspecified:
                self = .unspecified
            case .ultraLight:
                self = .ultraLight
            case .thin:
                self = .thin
            case .light:
                self = .light
            case .regular:
                self = .regular
            case .medium:
                self = .medium
            case .semibold:
                self = .semibold
            case .bold:
                self = .bold
            case .heavy:
                self = .heavy
            case .black:
                self = . black
        }
    }
}
