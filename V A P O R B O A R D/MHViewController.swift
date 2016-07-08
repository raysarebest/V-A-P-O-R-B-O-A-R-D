//
//  MHViewController.swift
//  V A P O R B O A R D
//
//  Created by Michael Hulet on 6/10/16.
//  Copyright © 2016 Michael Hulet. All rights reserved.
//

import UIKit
import AVFoundation

class MHInstallViewController: UIViewController, NSLayoutManagerDelegate{
    @IBOutlet weak var instructionsView: UITextView!
    @IBOutlet weak var tryButton: UIButton!
    override func viewDidLoad() -> Void{
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        instructionsView.layoutManager.delegate = self
        instructionsView.addObserver(self, forKeyPath: "contentSize", options: .New, context: nil)
        instructionsView.addObserver(self, forKeyPath: "center", options: .New, context: nil)
        navigationController?.navigationBar.barTintColor = UIColor(r: 44, g: 254, b: 236)
        tryButton.layer.borderColor = UIColor(r: 44, g: 254, b: 236).CGColor
        tryButton.layer.borderWidth = 1
        tryButton.layer.cornerRadius = 10
        //tryButton.addTarget(self, action: #selector(centerInstructions), forControlEvents: .TouchUpInside)
    }

    override func viewWillAppear(animated: Bool) -> Void{
        super.viewWillAppear(animated)
        centerInstructions()
    }

    override func viewWillDisappear(animated: Bool) -> Void{
        super.viewWillDisappear(animated)
        centerInstructions()
    }

    func centerInstructions() -> Void{
        var topCorrect: CGFloat = (instructionsView.bounds.size.height - instructionsView.contentSize.height * instructionsView.zoomScale) / 2
        topCorrect = topCorrect < 0 ? 0 : topCorrect
        instructionsView.contentOffset = CGPointMake(0, -topCorrect)
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) -> Void{
        centerInstructions()
    }

    func layoutManager(layoutManager: NSLayoutManager, lineSpacingAfterGlyphAtIndex glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> MHLineSpacing{
        return defaultLineSpacing
    }
}
