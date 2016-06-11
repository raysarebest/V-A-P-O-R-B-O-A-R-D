//
//  KeyboardViewController.swift
//  K E Y B O A R D
//
//  Created by Michael Hulet on 6/10/16.
//  Copyright © 2016 Michael Hulet. All rights reserved.
//

import UIKit

class MHKeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!

    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = UINib(nibName: "K E Y B O A R D   V I E W", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        
        // Perform custom UI setup here

        view.backgroundColor = UIColor(r: 44, g: 254, b: 236)
        for row in view.subviews{
            for button in row.subviews where (button as? UIButton)?.titleLabel?.text?.length == 1{
                (button as! UIButton).addTarget(self, action: #selector(self.pressed(_:)), forControlEvents: .TouchDown)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

    @objc func pressed(key: UIButton){
        print("Pressed \(key.titleLabel!.text!)")
    }

}


extension UIColor{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat){
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a / 100)
    }
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
        self.init(r: r, g: g, b: b, a: 100)
    }
}

extension String{
    var length: Int{
        get{
            return characters.count
        }
    }
}