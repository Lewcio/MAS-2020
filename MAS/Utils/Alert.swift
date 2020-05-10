//
//  Alert.swift
//  MAS
//
//  Created by m.lewandowski on 09/05/2020.
//  Copyright © 2020 pjatk. All rights reserved.
//

import Foundation

import UIKit
import Foundation

class AlertBuilder {
    private let alert: AlertController
    
    init(title: String = "", style: UIAlertController.Style = .alert) {
        alert = AlertController(title: title, message: nil, preferredStyle: style)
        alert.view.accessibilityIdentifier = "AlertViewController"
    }
    
    func with(title: String) -> AlertBuilder {
        alert.title = title
        return self
    }
    
    func with(message: String) -> AlertBuilder {
        alert.message = message
        return self
    }
    
    func withAction(title: String?, style: UIAlertAction.Style, handler: (() -> Void)? = nil) -> AlertBuilder {
        alert.addAction(UIAlertAction(title: title, style: style, handler: { _ in handler?() }))
        return self
    }
    
    func withDefaultAction(title: String?, handler: (() -> Void)? = nil) -> AlertBuilder {
        return withAction(title: title, style: .default, handler: handler)
    }
    
    func withCancelAction(title: String?, handler: (() -> Void)? = nil) -> AlertBuilder {
        return withAction(title: title, style: .cancel, handler: handler)
    }
    
    func withPreferredAction(title: String?, handler: (() -> Void)? = nil) -> AlertBuilder {
        let action = UIAlertAction(title: title, style: .default, handler: { _ in handler?() })
        alert.addAction(action)
        alert.preferredAction = action
        return self
    }
    
    func present(completion: (() -> Void)? = nil) {
        alert.show()
    }
}

extension AlertBuilder {
    func withError(message: String, handler: (() -> Void)? = nil) -> AlertBuilder {
        return with(title: R.string.localizable.error())
            .with(message: message)
            .withDefaultAction(title: R.string.localizable.ok(), handler: handler)
    }
    
    func withJailbreak() -> AlertBuilder {
        return with(title: R.string.localizable.error())
            .with(message: R.string.localizable.jailbrokenDeviceMessage())
    }
    
    func withUnsupportedAppVersion(handler: @escaping () -> Void) -> AlertBuilder {
        return with(title: R.string.localizable.unsupportedAppVersionTitle())
            .with(message: R.string.localizable.unsupportedAppVersionMessage())
            .withDefaultAction(title: R.string.localizable.unsupportedAppVersionButton(), handler: handler)
    }
    
    public func withTouchID() -> AlertBuilder {
        return with(message: R.string.localizable.loginWithPINViewControllerLoginWithTouchBlocked())
            .withDefaultAction(title: R.string.localizable.ok())
    }
    
    public func withQuestionMark(message: String) -> AlertBuilder {
        return with(message: message)
                .withCancelAction(title: R.string.localizable.ok())
    }
    
    func presentPairingInterruptAlert(backRouteHandler: (() -> Void)? = nil ) {
        with(title: R.string.localizable.pairingCloseProcessAlertTitle())
            .with(message: R.string.localizable.pairingCloseProcessAlertMessage())
            .withDefaultAction(title: R.string.localizable.pairingCloseProcessAlertClose(), handler: backRouteHandler)
            .withPreferredAction(title: R.string.localizable.pairingCloseProcessAlertCancel())
            .present()
    }
    
    func presentEmailSentAlert() {
        with(title: R.string.localizable.pairingEmailVerificationEmailSentAlertTitle())
            .with(message: R.string.localizable.pairingEmailVerificationEmailSentAlertMessage())
            .withCancelAction(title: R.string.localizable.ok(), handler: nil)
            .present()
    }
    
    func presentForgetPasswordAlert() {
        with(title: R.string.localizable.loginForgotAlertTitle())
            .with(message: R.string.localizable.loginForgotAlertMessage())
            .withCancelAction(title: R.string.localizable.ok(), handler: nil)
            .present()
    }
}
