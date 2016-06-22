//
//  MHAppearance.swift
//  V A P O R B O A R D
//
//  Created by Michael Hulet on 6/21/16.
//  Copyright © 2016 Michael Hulet. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r: Int, g: Int, b: Int, a: Int){
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 100)
    }
    convenience init(r: Int, g: Int, b: Int){
        self.init(r: r, g: g, b: b, a: 100)
    }
    var red: CGFloat{
        get{
            var r: CGFloat = 0
            getRed(&r, green: nil, blue: nil, alpha: nil)
            return r
        }
    }
    var green: CGFloat{
        get{
            var g: CGFloat = 0
            getRed(nil, green: &g, blue: nil, alpha: nil)
            return g
        }
    }
    var blue: CGFloat{
        get{
            var b: CGFloat = 0
            getRed(nil, green: nil, blue: &b, alpha: nil)
            return b
        }
    }
    var alpha: CGFloat{
        get{
            var a: CGFloat = 0
            getRed(nil, green: nil, blue: nil, alpha: &a)
            return a
        }
    }
    var hue: CGFloat{
        get{
            var h: CGFloat = 0
            getHue(&h, saturation: nil, brightness: nil, alpha: nil)
            return h
        }
    }
    var saturation: CGFloat{
        get{
            var s: CGFloat = 0
            getHue(nil, saturation: &s, brightness: nil, alpha: nil)
            return s
        }
    }
    var brightness: CGFloat{
        get{
            var b: CGFloat = 0
            getHue(nil, saturation: nil, brightness: &b, alpha: nil)
            return b
        }
    }
}

func verticalGradient(rect: CGRect, top: UIColor, bottom: UIColor) -> CAGradientLayer{
    let gradient = CAGradientLayer()
    gradient.frame = rect
    gradient.colors = [top.CGColor, bottom.CGColor]
    return gradient
}

extension UIView{
    func setBackground(gradient g: CAGradientLayer) -> Void{
        layer.insertSublayer(g, atIndex: 0)
        layer.sublayers![0].cornerRadius = layer.cornerRadius
    }
}
