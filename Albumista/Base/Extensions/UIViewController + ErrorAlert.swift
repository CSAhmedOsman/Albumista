//
//  UIViewController + ErrorAlert.swift
//  Albumista
//
//  Created by Mac on 12/12/2024.
//

import UIKit
import SwiftMessages

extension UIViewController {
    func showErrorAlert(messageTheme: Theme = .error, titleMessage: String = K.AppConstants.error, bodyMessage: String, position: SwiftMessages.PresentationStyle = .top) {
        DispatchQueue.main.async {
            let view = MessageView.viewFromNib(layout: .cardView)
            view.configureTheme(messageTheme)
            view.configureDropShadow()
            view.button?.isHidden = true
            view.bodyLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            view.configureContent(title: titleMessage, body: bodyMessage)
            view.backgroundView?.layer.cornerRadius = 8
            
            var config = SwiftMessages.Config()
            config.presentationStyle = position
            config.presentationContext = .window(windowLevel: .alert)
            config.duration = .seconds(seconds: 3)
            config.dimMode = .gray(interactive: true)
            config.interactiveHide = false
            
            SwiftMessages.show(config: config, view: view)
        }
    }
}
