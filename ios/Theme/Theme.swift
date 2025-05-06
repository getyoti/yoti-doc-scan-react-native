//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

import Foundation
import YotiSDKDesign

struct Theme: Decodable {
    var lightPrimaryColor: UIColor?
    var darkPrimaryColor: UIColor?
    let lightColorTheme: YotiSDKColorTheme?
    let darkColorTheme: YotiSDKColorTheme?
    let typographyTheme: YotiSDKTypographyTheme?
    var spacingMode: YotiSDKSpacingMode?
    let shapeTheme: YotiSDKShapeTheme?
    var iconTheme: YotiSDKIconTheme?
    let illustrationTheme: YotiSDKIllustrationTheme?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let lightPrimaryColor = try container.decodeIfPresent(String.self, forKey: .lightPrimaryColor) {
            self.lightPrimaryColor = UIColor(hexString: lightPrimaryColor)
        }
        if let darkPrimaryColor = try container.decodeIfPresent(String.self, forKey: .darkPrimaryColor) {
            self.darkPrimaryColor = UIColor(hexString: darkPrimaryColor)
        }
        lightColorTheme = try container.decodeIfPresent(ColorTheme.self, forKey: .lightColorTheme)
        darkColorTheme = try container.decodeIfPresent(ColorTheme.self, forKey: .darkColorTheme)
        typographyTheme = try container.decodeIfPresent(TypographyTheme.self, forKey: .typographyTheme)
        if let rawValue = try container.decodeIfPresent(String.self, forKey: .spacingMode), !rawValue.isEmpty {
            let spacingMode = SpacingMode(rawValue: rawValue)!
            self.spacingMode = YotiSDKSpacingMode(spacingMode)
        }
        shapeTheme = try container.decodeIfPresent(ShapeTheme.self, forKey: .shapeTheme)
        if #available(iOS 13, *) {
            iconTheme = try container.decodeIfPresent(IconTheme.self, forKey: .iconTheme)
        }
        illustrationTheme = try container.decodeIfPresent(IllustrationTheme.self, forKey: .illustrationTheme)
    }

    private enum CodingKeys: String, CodingKey {
        case lightPrimaryColor = "light_primary_color"
        case darkPrimaryColor = "dark_primary_color"
        case lightColorTheme = "light_color_theme"
        case darkColorTheme = "dark_color_theme"
        case typographyTheme = "typography_theme"
        case spacingMode = "spacing_mode"
        case shapeTheme = "shape_theme"
        case iconTheme = "icon_theme"
        case illustrationTheme = "illustration_theme"
    }
}
