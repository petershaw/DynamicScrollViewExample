//
//  ColoumnMasterViewController.swift
//  UIrowsExample
//
//  Created by Kris Wolff on 03/06/15.
//  Copyright (c) 2015 aus der Technik. All rights reserved.
//

import Foundation
import Cocoa

class ColoumnMasterViewController: NSViewController {
    
    @IBOutlet weak var scrollingView: NSScrollView!
    
    var position = 0
    var contentView: NSView?
    var widthtContraints: NSLayoutConstraint?
    
    override func viewDidLoad() {
        contentView = NSView(frame: NSRect(x: 0, y: 0, width: 3000, height: self.view.frame.height))
  
        contentView!.wantsLayer = true
        contentView!.layer?.backgroundColor =  NSColor.clearColor().CGColor
        
        
        add()
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.6, target: self, selector: Selector("add"), userInfo: nil, repeats: true)
        
        scrollingView.documentView = contentView
        
        autoLayout(contentView!)
    }
    
    func add(){
        println("add view on position \(position)")
        let vc: NSViewController = self.storyboard?.instantiateControllerWithIdentifier("coloumn_view_controller") as! NSViewController
        vc.view.setFrameOrigin(NSPoint(x: (position++ * 130), y: 0))
        vc.view.setFrameSize(NSSize(width: 130, height: self.view.frame.height))
        vc.view.wantsLayer = true
        vc.view.layer!.backgroundColor = getRandomColor().CGColor
        contentView!.addSubview(vc.view)

        updateWidth()
    }
    
    func autoLayout(contentView: NSView){
        let topPinContraints = NSLayoutConstraint(
            item: contentView
            , attribute: NSLayoutAttribute.Top
            , relatedBy: .Equal
            , toItem: contentView.superview
            , attribute: NSLayoutAttribute.Top
            , multiplier: 1.0
            , constant: 0
        )
        let bottomPinContraints = NSLayoutConstraint(
              item: contentView
            , attribute: NSLayoutAttribute.Bottom
            , relatedBy: .Equal
            , toItem: contentView.superview
            , attribute: NSLayoutAttribute.Bottom
            , multiplier: 1.0
            , constant: 0
        )

        println("heightContraints \(contentView.superview!.frame.height)")
        let heightContraints = NSLayoutConstraint(
            item: contentView
            , attribute: NSLayoutAttribute.Height
            , relatedBy: .Equal
            , toItem: contentView.superview!
            , attribute: NSLayoutAttribute.Height
            , multiplier: 1.0
            , constant: 0
        )
        println("widthtContraints \(contentView.superview!.frame.width)")
        let calculatedWith: CGFloat = (CGFloat) (contentView.subviews.count * 130)
        widthtContraints = NSLayoutConstraint(
            item: contentView
            , attribute: NSLayoutAttribute.Width
            , relatedBy: .Equal
            , toItem: nil
            , attribute: NSLayoutAttribute.Width
            , multiplier: 1.0
            , constant: 0
        )
        widthtContraints!.constant = calculatedWith
        
        NSLayoutConstraint.activateConstraints([
              topPinContraints
             , bottomPinContraints
             , heightContraints
             , widthtContraints!
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.needsLayout = true
        
    }
    
    func updateWidth(){
        let calculatedWith: CGFloat = (CGFloat) (contentView!.subviews.count * 130)
        if (widthtContraints != nil) {
            widthtContraints!.constant = calculatedWith
        }
    }
    
    func getRandomColor() -> NSColor{
        var randomRed:CGFloat = CGFloat(drand48())
        var randomGreen:CGFloat = CGFloat(drand48())
        var randomBlue:CGFloat = CGFloat(drand48())
        return NSColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.3)
    }
    
}
