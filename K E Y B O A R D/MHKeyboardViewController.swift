//
//  KeyboardViewController.swift
//  K E Y B O A R D
//
//  Created by Michael Hulet on 6/10/16.
//  Copyright © 2016 Michael Hulet. All rights reserved.
//

import UIKit

enum MHKeyCase{
    case Capital
    case Lower
    case Punctuation
}

class MHKeyboardViewController: UIInputViewController{

    @IBOutlet var specialKeys: [UIButton]!
    @IBOutlet weak var nextKeyboardButton: UIButton!
    @IBOutlet weak var backspaceKey: UIButton!
    @IBOutlet weak var shiftKey: UIButton!
    @IBOutlet weak var alternateLayoutKey: UIButton!

    override func updateViewConstraints() -> Void{
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() -> Void{
        super.viewDidLoad()

        view = UINib(nibName: "K E Y B O A R D   V I E W", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        nextKeyboardButton.addTarget(self, action: #selector(self.advanceToNextInputMode), forControlEvents: .TouchUpInside)
    }

    override func viewWillAppear(animated: Bool) -> Void{
        super.viewWillAppear(animated)
        let darkGreen = UIColor(r: 90, g: 183, b: 160)
        view.setBackground(gradient: verticalGradient(view.frame, colors: [darkGreen, view.backgroundColor!, darkGreen]))
        eachKey{(key: UIButton) in
            key.layer.cornerRadius = 10
            key.addTarget(self, action: #selector(self.pressed(_:)), forControlEvents: .TouchDown)
            key.addTarget(self, action: #selector(self.cleanUpPress(_:)), forControlEvents: .TouchUpInside)
            key.addTarget(self, action: #selector(self.cleanUpPress(_:)), forControlEvents: .TouchCancel)
            key.imageView?.contentMode = .ScaleAspectFit
            if self.specialKeys.contains(key){
                key.setBackground(gradient: verticalGradient(key.frame, colors: [UIColor(r: 183, g: 119, b: 240), UIColor(r: 123, g: 85, b: 205)]))
            }
            else{
                key.setBackground(gradient: verticalGradient(key.frame, top: UIColor(r: 253, g: 130, b: 159), bottom: key.backgroundColor!))
            }
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
            let keyHeight = key.superview!.bounds.height - 2
            pinkGradient.frame = CGRect(origin: key.bounds.origin, size: CGSize(width: key.bounds.width, height: keyHeight))
            if key.imageView != nil{
                guard key == self.shiftKey else{
                    let factor = keyHeight * 0.2
                    key.imageEdgeInsets = UIEdgeInsets(top: factor, left: 0, bottom: factor, right: 0)
                    return
                }
                let factor = key.bounds.width * 0.35
                key.imageEdgeInsets = UIEdgeInsets(top: 0, left: factor, bottom: 0, right: factor)
            }
        })
    }

    func eachKey(closure: (key: UIButton) -> Void) -> Void{
        for sub in view.subviews{
            guard let button = sub as? UIButton else{
                for button in sub.subviews{
                    guard let button = button as? UIButton else{
                        continue
                    }
                    closure(key: button)
                }
                continue
            }
            closure(key: button)
        }
    }

    @objc func pressed(key: UIButton) -> Void{
        if key.titleLabel?.text?.length != 3 && key.imageView?.image == nil{
            textDocumentProxy.insertText(key.titleLabel!.text! == "ＳＰＡＣＥ" ? "   " : key.titleLabel!.text!)
        }
        else if key == backspaceKey{
            guard textDocumentProxy.documentContextBeforeInput?.characters.last != " " else{
                repeat{
                    textDocumentProxy.deleteBackward()
                }while textDocumentProxy.documentContextBeforeInput?.characters.last == " "
                return
            }
            textDocumentProxy.deleteBackward()
        }
        key.backgroundColor = UIColor(r: 216, g: 40, b: 130)
        invertGradient(key: key)
    }

    @objc func cleanUpPress(key: UIButton) -> Void{
        key.backgroundColor = UIColor(r: 250, g: 48, b: 129)
        invertGradient(key: key)
    }

    func invertGradient(key key: UIButton) -> Void{
        guard let gradient = key.layer.sublayers?[0] as? CAGradientLayer else{
            return
        }
        if gradient.colors!.count % 2 == 0{
            gradient.colors = gradient.colors?.reverse()
        }
        else{
            var new = [AnyObject]()
            for i in 0..<gradient.colors!.count - 1{
                new.append(gradient.colors![i + 1])
            }
            new.append(gradient.colors![gradient.colors!.count - 2])
            gradient.colors = new
        }
    }
}

extension String{
    var length: Int{
        get{
            return characters.count
        }
    }
}
