//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

import YotiSDKDesign

struct TypographyTheme: YotiSDKTypographyTheme, Decodable {
    private let smallHeadline: TypographyStyle
    private let smallTitle: TypographyStyle
    private let smallBody: TypographyStyle
    private let smallProminentBody: TypographyStyle
    private let smallLabel: TypographyStyle
    private let smallProminentLabel: TypographyStyle
    private let mediumHeadline: TypographyStyle
    private let mediumTitle: TypographyStyle
    private let mediumBody: TypographyStyle
    private let mediumProminentBody: TypographyStyle
    private let mediumLabel: TypographyStyle
    private let mediumProminentLabel: TypographyStyle
    private let largeHeadline: TypographyStyle
    private let largeTitle: TypographyStyle
    private let largeBody: TypographyStyle
    private let largeProminentBody: TypographyStyle
    private let largeLabel: TypographyStyle
    private let largeProminentLabel: TypographyStyle

    private enum CodingKeys: String, CodingKey {
        case smallHeadline = "small_headline"
        case smallTitle = "small_title"
        case smallBody = "small_body"
        case smallProminentBody = "small_prominent_body"
        case smallLabel = "small_label"
        case smallProminentLabel = "small_prominent_label"
        case mediumHeadline = "medium_headline"
        case mediumTitle = "medium_title"
        case mediumBody = "medium_body"
        case mediumProminentBody = "medium_prominent_body"
        case mediumLabel = "medium_label"
        case mediumProminentLabel = "medium_prominent_label"
        case largeHeadline = "large_headline"
        case largeTitle = "large_title"
        case largeBody = "large_body"
        case largeProminentBody = "large_prominent_body"
        case largeLabel = "large_label"
        case largeProminentLabel = "large_prominent_label"
    }
}

extension TypographyTheme {
    func headline(scale: YotiSDKTypographyScale) -> YotiSDKTypographyStyle {
        switch scale {
            case .small:
                smallHeadline
            case .medium:
                mediumHeadline
            case .large:
                largeHeadline
        }
    }

    func title(scale: YotiSDKTypographyScale) -> YotiSDKTypographyStyle {
        switch scale {
            case .small:
                smallTitle
            case .medium:
                mediumTitle
            case .large:
                largeTitle
        }
    }

    func body(scale: YotiSDKTypographyScale) -> YotiSDKTypographyStyle {
        switch scale {
            case .small:
                smallBody
            case .medium:
                mediumBody
            case .large:
                largeBody
        }
    }

    func prominentBody(scale: YotiSDKTypographyScale) -> YotiSDKTypographyStyle {
        switch scale {
            case .small:
                smallProminentBody
            case .medium:
                mediumProminentBody
            case .large:
                largeProminentBody
        }
    }

    func label(scale: YotiSDKTypographyScale) -> YotiSDKTypographyStyle {
        switch scale {
            case .small:
                smallLabel
            case .medium:
                mediumLabel
            case .large:
                largeLabel
        }
    }

    func prominentLabel(scale: YotiSDKTypographyScale) -> YotiSDKTypographyStyle {
        switch scale {
            case .small:
                smallProminentLabel
            case .medium:
                mediumProminentLabel
            case .large:
                largeProminentLabel
        }
    }
}
