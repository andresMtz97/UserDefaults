//
//  HidingKeyboardViewController.swift
//  ShowCase
//
//  Created by Rafael González on 12/08/23.
//

import Foundation
import UIKit

extension ViewController {
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }    
}
