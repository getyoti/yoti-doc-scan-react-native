//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

import UIKit
import YotiSDKDesign

struct ColorTheme: YotiSDKColorTheme, Decodable {
    let actionEmphasisPrimaryPressed: UIColor
    let actionPrimary: UIColor
    let actionPrimaryDisabled: UIColor
    let actionPrimaryPressed: UIColor
    let actionSuccessEnabled: UIColor
    let backgroundEmphasisSolid: UIColor
    let backgroundInfo: UIColor
    let backgroundSolid: UIColor
    let backgroundSolid2: UIColor
    let backgroundWarning: UIColor
    let border: UIColor
    let border2: UIColor
    let border3: UIColor
    let borderCritical: UIColor
    let borderEmphasis2: UIColor
    let icon: UIColor
    let icon2: UIColor
    let icon3: UIColor
    let iconEmphasis: UIColor
    let iconWarning: UIColor
    let shimmerBackground: UIColor
    let shimmerForeground: UIColor
    let text: UIColor
    let text2: UIColor
    let textCritical: UIColor
    let textEmphasis: UIColor
    let textLinkEnabled: UIColor
    let textLinkPressed: UIColor
    let textWarning: UIColor

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let actionEmphasisPrimaryPressed = try container.decode(String.self, forKey: .actionEmphasisPrimaryPressed)
        let actionPrimary = try container.decode(String.self, forKey: .actionPrimary)
        let actionPrimaryDisabled = try container.decode(String.self, forKey: .actionPrimaryDisabled)
        let actionPrimaryPressed = try container.decode(String.self, forKey: .actionPrimaryPressed)
        let actionSuccessEnabled = try container.decode(String.self, forKey: .actionSuccessEnabled)
        let backgroundEmphasisSolid = try container.decode(String.self, forKey: .backgroundEmphasisSolid)
        let backgroundInfo = try container.decode(String.self, forKey: .backgroundInfo)
        let backgroundSolid = try container.decode(String.self, forKey: .backgroundSolid)
        let backgroundSolid2 = try container.decode(String.self, forKey: .backgroundSolid2)
        let backgroundWarning = try container.decode(String.self, forKey: .backgroundWarning)
        let border = try container.decode(String.self, forKey: .border)
        let border2 = try container.decode(String.self, forKey: .border2)
        let border3 = try container.decode(String.self, forKey: .border3)
        let borderCritical = try container.decode(String.self, forKey: .borderCritical)
        let borderEmphasis2 = try container.decode(String.self, forKey: .borderEmphasis2)
        let icon = try container.decode(String.self, forKey: .icon)
        let icon2 = try container.decode(String.self, forKey: .icon2)
        let icon3 = try container.decode(String.self, forKey: .icon3)
        let iconEmphasis = try container.decode(String.self, forKey: .iconEmphasis)
        let iconWarning = try container.decode(String.self, forKey: .iconWarning)
        let shimmerBackground = try container.decode(String.self, forKey: .shimmerBackground)
        let shimmerForeground = try container.decode(String.self, forKey: .shimmerForeground)
        let text = try container.decode(String.self, forKey: .text)
        let text2 = try container.decode(String.self, forKey: .text2)
        let textCritical = try container.decode(String.self, forKey: .textCritical)
        let textEmphasis = try container.decode(String.self, forKey: .textEmphasis)
        let textLinkEnabled = try container.decode(String.self, forKey: .textLinkEnabled)
        let textLinkPressed = try container.decode(String.self, forKey: .textLinkPressed)
        let textWarning = try container.decode(String.self, forKey: .textWarning)
        self.actionEmphasisPrimaryPressed = UIColor(hexString: actionEmphasisPrimaryPressed)
        self.actionPrimary = UIColor(hexString: actionPrimary)
        self.actionPrimaryDisabled = UIColor(hexString: actionPrimaryDisabled)
        self.actionPrimaryPressed = UIColor(hexString: actionPrimaryPressed)
        self.actionSuccessEnabled = UIColor(hexString: actionSuccessEnabled)
        self.backgroundEmphasisSolid = UIColor(hexString: backgroundEmphasisSolid)
        self.backgroundInfo = UIColor(hexString: backgroundInfo)
        self.backgroundSolid = UIColor(hexString: backgroundSolid)
        self.backgroundSolid2 = UIColor(hexString: backgroundSolid2)
        self.backgroundWarning = UIColor(hexString: backgroundWarning)
        self.border = UIColor(hexString: border)
        self.border2 = UIColor(hexString: border2)
        self.border3 = UIColor(hexString: border3)
        self.borderCritical = UIColor(hexString: borderCritical)
        self.borderEmphasis2 = UIColor(hexString: borderEmphasis2)
        self.icon = UIColor(hexString: icon)
        self.icon2 = UIColor(hexString: icon2)
        self.icon3 = UIColor(hexString: icon3)
        self.iconEmphasis = UIColor(hexString: iconEmphasis)
        self.iconWarning = UIColor(hexString: iconWarning)
        self.shimmerBackground = UIColor(hexString: shimmerBackground)
        self.shimmerForeground = UIColor(hexString: shimmerForeground)
        self.text = UIColor(hexString: text)
        self.text2 = UIColor(hexString: text2)
        self.textCritical = UIColor(hexString: textCritical)
        self.textEmphasis = UIColor(hexString: textEmphasis)
        self.textLinkEnabled = UIColor(hexString: textLinkEnabled)
        self.textLinkPressed = UIColor(hexString: textLinkPressed)
        self.textWarning = UIColor(hexString: textWarning)
    }

    private enum CodingKeys: String, CodingKey {
        case actionEmphasisPrimaryPressed = "action_emphasis_primary_pressed"
        case actionPrimary = "action_primary"
        case actionPrimaryDisabled = "action_primary_disabled"
        case actionPrimaryPressed = "action_primary_pressed"
        case actionSuccessEnabled = "action_success_enabled"
        case backgroundEmphasisSolid = "background_emphasis_solid"
        case backgroundInfo = "background_info"
        case backgroundSolid = "background_solid"
        case backgroundSolid2 = "background_solid2"
        case backgroundWarning = "background_warning"
        case border
        case border2
        case border3
        case borderCritical = "border_critical"
        case borderEmphasis2 = "border_emphasis2"
        case icon
        case icon2
        case icon3
        case iconEmphasis = "icon_emphasis"
        case iconWarning = "icon_warning"
        case shimmerBackground = "shimmer_background"
        case shimmerForeground = "shimmer_foreground"
        case text
        case text2
        case textCritical = "text_critical"
        case textEmphasis = "text_emphasis"
        case textLinkEnabled = "text_link_enabled"
        case textLinkPressed = "text_link_pressed"
        case textWarning = "text_warning"
    }
}
