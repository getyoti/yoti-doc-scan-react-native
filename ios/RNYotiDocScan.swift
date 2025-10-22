//
//  Copyright © 2025 Yoti Ltd. All rights reserved.
//

import Foundation
import React
import YotiSDKCore
import YotiSDKDesign
#if canImport(YotiSDKIdentityDocument)
import YotiSDKIdentityDocument
#endif
#if canImport(YotiSDKSupplementaryDocument)
import YotiSDKSupplementaryDocument
#endif
#if canImport(YotiSDKFaceTec)
import YotiSDKFaceTec
#endif
#if canImport(YotiSDKFaceCapture)
import YotiSDKFaceCapture
#endif

@objc(RNYotiDocScan) final class RNYotiDocScan: NSObject {
    private var rootViewController: UIViewController?
    private var navigationController: YotiSDKNavigationController?
    private var sessionID = ""
    private var sessionToken = ""
    private var completion: RCTResponseSenderBlock?
    private var _configuration: Configuration?
}

extension RNYotiDocScan {
    @objc static func requiresMainQueueSetup() -> Bool {
        false
    }

    @objc func setConfiguration(_ configuration: Dictionary<String, String>) {
        guard let data = try? JSONSerialization.data(withJSONObject: configuration) else {
            preconditionFailure("Unable to serialize configuration dictionary")
        }
        guard let fileConfiguration = try? JSONDecoder().decode(FileConfiguration.self, from: data) else {
            preconditionFailure("Unable to decode file configuration")
        }
        _configuration = Configuration(fileConfiguration: fileConfiguration)
    }

    @objc func setRequestCode(_ requestCode: Int) {
        // Required to maintain cross-platform API compatibility
    }

    @objc func start(_ sessionID: String, sessionToken: String, completion: @escaping RCTResponseSenderBlock) {
        self.sessionID = sessionID
        self.sessionToken = sessionToken
        self.completion = completion
        DispatchQueue.performOnMainThread { [weak self] in
            guard let self else {
                return
            }
            navigationController = YotiSDKNavigationController()
            navigationController?.sdkDataSource = self
            navigationController?.sdkDelegate = self
            rootViewController = RCTPresentedViewController()
            rootViewController?.present(navigationController!, animated: true)
        }
    }
}

extension RNYotiDocScan: YotiSDKDataSource, YotiSDKDelegate {
    func configuration() -> YotiSDKConfiguration {
        .init(
            sessionID: sessionID,
            sessionToken: sessionToken,
            singleFlow: _configuration?.singleFlow ?? false,
            moduleTypes: moduleTypes(),
            options: options(),
            theme: theme()
        )
    }

    func isReactNativeClient() -> Bool {
        true
    }

    func didFinish(statusCode: Int) {
        rootViewController?.dismiss(animated: true)
        completion?([statusCode])
    }
}

fileprivate extension RNYotiDocScan {
    func moduleTypes() -> [YotiSDKModule.Type] {
        var moduleTypes = [YotiSDKModule.Type]()
        let includeImportableModuleTypes = _configuration == nil
            || (_configuration?.singleFlow == nil || _configuration?.singleFlow == false)
            && _configuration?.includeIdentityDocumentModuleType == nil
            && _configuration?.includeSupplementaryDocumentModuleType == nil
            && _configuration?.includeFaceTecModuleType == nil
            && _configuration?.includeFaceCaptureModuleType == nil
        #if canImport(YotiSDKIdentityDocument)
        if includeImportableModuleTypes || _configuration?.includeIdentityDocumentModuleType == true {
            moduleTypes.append(YotiSDKIdentityDocumentModule.self)
        }
        #endif
        #if canImport(YotiSDKSupplementaryDocument)
        if includeImportableModuleTypes || _configuration?.includeSupplementaryDocumentModuleType == true {
            moduleTypes.append(YotiSDKSupplementaryDocumentModule.self)
        }
        #endif
        #if canImport(YotiSDKFaceTec)
        if includeImportableModuleTypes || _configuration?.includeFaceTecModuleType == true {
            moduleTypes.append(YotiSDKFaceTecModule.self)
        }
        #endif
        #if canImport(YotiSDKFaceCapture)
        if includeImportableModuleTypes || _configuration?.includeFaceCaptureModuleType == true {
            moduleTypes.append(YotiSDKFaceCaptureModule.self)
        }
        #endif
        return moduleTypes
    }

    func options() -> [YotiSDKOption]? {
        if _configuration?.disableIdentityDocumentCaptureEdgeDetection == true {
            return [.disableIdentityDocumentCaptureEdgeDetection]
        } else {
            return nil
        }
    }

    func theme() -> YotiSDKTheme? {
        guard let theme = _configuration?.theme else {
            return nil
        }
        let builder = YotiSDKThemeBuilder()
        builder.lightPrimaryColor = theme.lightPrimaryColor
        builder.darkPrimaryColor = theme.darkPrimaryColor
        builder.lightColorTheme = theme.lightColorTheme
        builder.darkColorTheme = theme.darkColorTheme
        builder.typographyTheme = theme.typographyTheme
        builder.spacingMode = theme.spacingMode
        builder.shapeTheme = theme.shapeTheme
        builder.iconTheme = theme.iconTheme
        builder.illustrationTheme = theme.illustrationTheme
        return builder.build()
    }
}
