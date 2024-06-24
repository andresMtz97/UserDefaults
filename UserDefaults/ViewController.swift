//
//  ViewController.swift
//  ShowCase
//
//  Created by Rafael González on 12/08/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    @IBOutlet var fontSizeControl: UISlider!
    @IBOutlet var fontColorControl: UIColorWell!
    @IBOutlet var fontFamilyControl: UIPickerView!
    
    var currentFontFamily = UIFont.familyNames.first
    var currentFontSize = 17.0
    var currentFontRGBAColor = [CGFloat(128.0/255), CGFloat(128.0/255), CGFloat(128.0/255), CGFloat(1.0)]
    var currentFontFamilyIndex = 0
    
    let fontDataFamily = UIFont.familyNames.prefix(20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fontFamilyControl.delegate = self
        fontFamilyControl.dataSource = self
        textView.delegate = self
        // Do any additional setup after loading the view.
        textView.font = UIFont(name: currentFontFamily!, size: currentFontSize)
        textView.textColor = UIColor(red: currentFontRGBAColor[0], green: currentFontRGBAColor[1], blue: currentFontRGBAColor[2], alpha: currentFontRGBAColor[3])

        //set an action for valueChanged method
        fontColorControl.addTarget(self, action: #selector(fontColorControlChanged), for: .valueChanged)
        
        print("NSS: ", NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!)
        
        print("FMD: ", FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        currentFontFamily = getConfig(key: "fontFamily") as? String ?? currentFontFamily
        currentFontSize = getConfig(key: "fontSize") as? Double ?? currentFontSize
        currentFontRGBAColor = getConfig(key: "fontColor") as? [CGFloat] ?? currentFontRGBAColor
        currentFontFamilyIndex = getConfig(key: "fontFamilyIndex") as? Int ?? 0
        
        textView.font = UIFont(name: currentFontFamily!, size: currentFontSize)
        textView.textColor = UIColor(red: currentFontRGBAColor[0], green: currentFontRGBAColor[1], blue: currentFontRGBAColor[2], alpha: currentFontRGBAColor[3])
        
        fontSizeControl.value = Float(currentFontSize)
        fontColorControl.selectedColor = textView.textColor
        fontFamilyControl.selectRow(currentFontFamilyIndex, inComponent: 0, animated: false)
        //fontFamilyControl.reloadAllComponents()
    }
    
    @IBAction func fontSizeChanged(_ sender: UISlider) {
        currentFontSize = Double(sender.value.rounded())
        textView.font = UIFont(name: currentFontFamily!, size: currentFontSize)
        saveConfig(key: "fontSize", value: currentFontSize)
    }
    
    @objc func fontColorControlChanged(){
        currentFontRGBAColor = (fontColorControl.selectedColor?.cgColor.components!)!
        textView.textColor = fontColorControl.selectedColor
        saveConfig(key: "fontColor", value: currentFontRGBAColor)
    }
    
    
    
}

