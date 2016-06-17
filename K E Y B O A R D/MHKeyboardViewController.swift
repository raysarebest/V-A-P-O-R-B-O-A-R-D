//
//  KeyboardViewController.swift
//  K E Y B O A R D
//
//  Created by Michael Hulet on 6/10/16.
//  Copyright © 2016 Michael Hulet. All rights reserved.
//

import UIKit

class MHKeyboardViewController: UIInputViewController{

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var backspaceButton: UIButton!

    override func updateViewConstraints() -> Void{
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() -> Void{
        super.viewDidLoad()

        view = UINib(nibName: "K E Y B O A R D   V I E W", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        
        // Perform custom UI setup here

        view.backgroundColor = UIColor(r: 44, g: 254, b: 236)
        for row in view.subviews{
            for button in row.subviews{
                let button = (button as! UIButton)
                button.addTarget(self, action: #selector(self.pressed(_:)), forControlEvents: .TouchDown)
                button.addTarget(self, action: #selector(self.cleanUpPress(_:)), forControlEvents: .TouchUpInside)
                button.addTarget(self, action: #selector(self.cleanUpPress(_:)), forControlEvents: .TouchCancel)
            }
        }
        nextKeyboardButton.addTarget(self, action: #selector(self.advanceToNextInputMode), forControlEvents: .TouchUpInside)
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
    }

    @objc func pressed(key: UIButton) -> Void{
        key.backgroundColor = UIColor(r: 216, g: 40, b: 130)
        if key.titleLabel!.text!.length != 3{
            textDocumentProxy.insertText(key.titleLabel!.text! == "S P A C E" ? "   " : key.titleLabel!.text!)
        }
        else if key == backspaceButton{
            guard textDocumentProxy.documentContextBeforeInput?.characters.last != " " else{
                repeat{
                    textDocumentProxy.deleteBackward()
                }while textDocumentProxy.documentContextBeforeInput?.characters.last == " "
                return
            }
            textDocumentProxy.deleteBackward()
        }
    }
    @objc func cleanUpPress(key: UIButton) -> Void{
        key.backgroundColor = UIColor(r: 250, g: 48, b: 129)
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