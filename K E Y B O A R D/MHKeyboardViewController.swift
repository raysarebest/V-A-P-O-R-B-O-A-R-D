//
//  KeyboardViewController.swift
//  K E Y B O A R D
//
//  Created by Michael Hulet on 6/10/16.
//  Copyright © 2016 Michael Hulet. All rights reserved.
//

import UIKit

enum keyCase{
    case Capital
    case Lower
    case Punctuation
}

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
        view.backgroundColor = UIColor(r: 44, g: 254, b: 236)
        eachKey({(key: UIButton) in
            key.layer.cornerRadius = 10
            key.addTarget(self, action: #selector(self.pressed(_:)), forControlEvents: .TouchDown)
            key.addTarget(self, action: #selector(self.cleanUpPress(_:)), forControlEvents: .TouchUpInside)
            key.addTarget(self, action: #selector(self.cleanUpPress(_:)), forControlEvents: .TouchCancel)
            key.addObserver(self, forKeyPath: "frame", options: [], context: nil)
        })
        nextKeyboardButton.addTarget(self, action: #selector(self.advanceToNextInputMode), forControlEvents: .TouchUpInside)
    }

    override func viewWillAppear(animated: Bool) -> Void{
        super.viewWillAppear(animated)
        func displayGradient(view: UIView, bottom: UIColor) -> Void{
            view.setBackground(gradient: verticalGradient(view.frame, top: view.backgroundColor!, bottom: bottom))
        }
        displayGradient(view, bottom: UIColor(r: 90, g: 183, b: 160))
        eachKey{(key: UIButton) in
            displayGradient(key, bottom: UIColor(r: 253, g: 130, b: 159))
        }
    }

    override func viewDidLayoutSubviews() -> Void{
        super.viewDidLayoutSubviews()
        guard let greenGradient = view.layer.sublayers![0] as? CAGradientLayer else{
            return
        }
        greenGradient.frame = view.frame
        view.setBackground(gradient: greenGradient)
        eachKey({(key: UIButton) in
            guard let pinkGradient = key.layer.sublayers![0] as? CAGradientLayer else{
                return
            }
            //Wow this is a weird hack thanks Apple Engineering for not keeping UIView.frame or UIView.bounds updated during size changes, or even equal at any time
            pinkGradient.frame = CGRect(origin: key.bounds.origin, size: CGSize(width: key.bounds.width, height: key.superview!.bounds.height - 2))
        })
    }

    func eachKey(closure: (key: UIButton) -> Void) -> Void{
        for sub in view.subviews{
            for button in sub.subviews{
                guard let button = button as? UIButton else{
                    continue
                }
                closure(key: button)
            }
        }
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

    @objc override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) -> Void{
        print("Key: \(object!), Changes: \(change!)")
    }
}

extension String{
    var length: Int{
        get{
            return characters.count
        }
    }
}
