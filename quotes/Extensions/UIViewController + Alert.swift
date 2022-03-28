//
//  UIViewController + Alert.swift
//  quotes
//
//  Created by james on 28/03/2022.
//

import Foundation
import UIKit

extension UIViewController{

    public func openAlert(title: String,
                          message: String,
                          alertStyle:UIAlertController.Style,
                          actionTitles:[String],
                          actionStyles:[UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)]){

        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        
        alertController.view.tintColor = .darkGray
        
        self.present(alertController, animated: true) {
            
            alertController.view.superview?.subviews.first?.isUserInteractionEnabled = true
            alertController.view.superview?.subviews.first?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actionSheetBackgroundTapped)))
            
        }
    }
    
    @objc func actionSheetBackgroundTapped() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func openSimpleAlert(title: String, message: String) {
        
        self.openAlert(title: NSLocalizedString(title, comment: title),
                       message: NSLocalizedString(message, comment: message) ,
                       alertStyle: .alert,
                       actionTitles: ["Ok"],
                       actionStyles: [.default],
                       actions: [
                       
                        { []_ in
                            
                            //
                            
                        }
                       ])
        
    }
    
}
