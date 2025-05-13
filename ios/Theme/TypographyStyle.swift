//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

import CoreFoundation
import UIKit
import YotiSDKDesign

struct TypographyStyle: YotiSDKTypographyStyle, Decodable {
    var systemFontDesign: UIFontDescriptor.SystemDesign?
    var systemFontWeight: UIFont.Weight?
    let customFontName: String?
    let fontSize: CGFloat
    let lineHeightMultiple: CGFloat?
    let kern: CGFloat?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if #available(iOS 13, *), let rawValue = try container.decodeIfPresent(String.self, forKey: .systemFontDesign), !rawValue.isEmpty {
            let systemFontDesign = FontDesign(rawValue: rawValue)!
            self.systemFontDesign = UIFontDescriptor.SystemDesign(systemFontDesign)
        }
        if let rawValue = try container.decodeIfPresent(String.self, forKey: .systemFontWeight), !rawValue.isEmpty {
            let systemFontWeight = FontWeight(rawValue: rawValue)!
            self.systemFontWeight = UIFont.Weight(systemFontWeight)
        }
        customFontName = try container.decodeIfPresent(String.self, forKey: .customFontName)
        fontSize = try container.decode(CGFloat.self, forKey: .fontSize)
        lineHeightMultiple = try container.decodeIfPresent(CGFloat.self, forKey: .lineHeightMultiple)
        kern = try container.decodeIfPresent(CGFloat.self, forKey: .kern)
    }

    private enum CodingKeys: String, CodingKey {
        case systemFontDesign = "system_font_design"
        case systemFontWeight = "system_font_weight"
        case customFontName = "custom_font_name"
        case fontSize = "font_size"
        case lineHeightMultiple = "line_height_multiple"
        case kern
    }
}
