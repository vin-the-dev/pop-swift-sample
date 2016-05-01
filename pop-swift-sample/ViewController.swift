//
//  ViewController.swift
//  pop-swift-learning
//
//  Created by Vineeth Vijayan on 30/04/16.
//  Copyright © 2016 creativelogics. All rights reserved.
//

import UIKit
import Foundation
import pop

class ViewController: UIViewController, POPAnimationDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var animView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.viewDragged(_:)))
        animView.addGestureRecognizer(pan)
        animView.bringSubviewToFront(self.view)
    }
    
    func viewDragged(pan: UIPanGestureRecognizer) {
        if pan.state == UIGestureRecognizerState.Ended {
            var decayAnimation = POPDecayAnimation(propertyNamed: kPOPLayerPositionX)
            decayAnimation.velocity = pan.velocityInView(self.view).x
            decayAnimation.deceleration = 0.99
            pan.view?.pop_addAnimation(decayAnimation, forKey: "POPLayerPositionX")
            decayAnimation = POPDecayAnimation(propertyNamed: kPOPLayerPositionY)
            decayAnimation.velocity = pan.velocityInView(self.view).y
            decayAnimation.deceleration = 0.99
            pan.view?.pop_addAnimation(decayAnimation, forKey: "POPLayerPositionY")
            return
        }
        let translation = pan.translationInView(self.view)
        pan.view!.center = CGPointMake(pan.view!.center.x + translation.x, pan.view!.center.y + translation.y)
        pan.setTranslation(CGPointZero, inView: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnTapped(sender: AnyObject) {
        if segmentedControl.selectedSegmentIndex == 0 {
            viewAnimations()
        }
        else {
            layerAnimations()
        }
    }
    
    func layerAnimations() {
        if pickerView.selectedRowInComponent(0) == 0 {
            let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerBackgroundColor)
            springAnimation.toValue = UIColor.blueColor()
            springAnimation.delegate = self
            springAnimation.springBounciness = springBounciness
            springAnimation.name = "POPLayerBackgroundColor"
            animView.layer.pop_addAnimation(springAnimation, forKey: "POPLayerBackgroundColor")
        }
        if pickerView.selectedRowInComponent(0) == 1 {
            let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerBounds)
            springAnimation.toValue = NSValue(CGRect: CGRectMake(0, 0, 200, 200)) // first 2 values doesn't matter
            springAnimation.springBounciness = springBounciness
            springAnimation.delegate = self
            springAnimation.name = "POPLayerBounds"
            animView.layer.pop_addAnimation(springAnimation, forKey: "POPLayerBounds")
        }
        if pickerView.selectedRowInComponent(0) == 2 {
            let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
            springAnimation.toValue = NSValue(CGSize: CGSizeMake(3, 2))
            springAnimation.springBounciness = springBounciness
            springAnimation.delegate = self
            springAnimation.name = "POPLayerScaleXY"
            animView.layer.pop_addAnimation(springAnimation, forKey: "POPLayerScaleXY")
        }
        if pickerView.selectedRowInComponent(0) == 3 {
            let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerSize)
            springAnimation.toValue = NSValue(CGSize: CGSizeMake(300, 150))
            springAnimation.springBounciness = springBounciness
            springAnimation.delegate = self
            springAnimation.name = "POPLayerSize"
            animView.layer.pop_addAnimation(springAnimation, forKey: "POPLayerSize")
        }
        if pickerView.selectedRowInComponent(0) == 4 {
            let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerOpacity)
            springAnimation.toValue = 0
            springAnimation.springBounciness = springBounciness
            springAnimation.delegate = self
            springAnimation.name = "POPLayerOpacity"
            animView.layer.pop_addAnimation(springAnimation, forKey: "POPLayerOpacity")
        }
        if pickerView.selectedRowInComponent(0) == 5 {
            let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
            springAnimation.toValue = NSValue(CGRect: CGRectMake(130, 130, 0, 0))
            springAnimation.springBounciness = springBounciness
            springAnimation.delegate = self
            springAnimation.name = "POPLayerPosition"
            animView.layer.pop_addAnimation(springAnimation, forKey: "POPLayerPosition")
        }
        if pickerView.selectedRowInComponent(0) == 6 {
            let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionX)
            springAnimation.toValue = 130
            springAnimation.springBounciness = springBounciness
            springAnimation.delegate = self
            springAnimation.name = "POPLayerPositionX"
            animView.layer.pop_addAnimation(springAnimation, forKey: "POPLayerPositionX")
        }
        if pickerView.selectedRowInComponent(0) == 7 {
            let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            springAnimation.toValue = 230
            springAnimation.springBounciness = springBounciness
            springAnimation.delegate = self
            springAnimation.name = "POPLayerPositionY"
            animView.layer.pop_addAnimation(springAnimation, forKey: "POPLayerPositionY")
        }
        if pickerView.selectedRowInComponent(0) == 8 {
            let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
            springAnimation.toValue = (M_PI / 4) //2 M_PI is an entire rotation
            springAnimation.springBounciness = springBounciness
            springAnimation.delegate = self
            springAnimation.name = "POPLayerRotation"
            animView.layer.pop_addAnimation(springAnimation, forKey: "POPLayerRotation")
        }
        if pickerView.selectedRowInComponent(0) == 9{
            let springAnimation = POPSpringAnimation(propertyNamed: kPOPLayerCornerRadius)
            springAnimation.toValue = (animView.frame.height / 2)
            springAnimation.springBounciness = springBounciness
            springAnimation.delegate = self
            springAnimation.name = "POPLayerRotation"
            animView.layer.pop_addAnimation(springAnimation, forKey: "POPLayerRotation")
        }
    }
    
    let animLayerValues = ["Color",
                           "Size-LayerBounds",
                           "Size-Scale",
                           "Size-LayerSize",
                           "Opacity",
                           "Position",
                           "X Position",
                           "Y Position",
                           "Rotation",
                           "Corner Radius"]
    let springBounciness:CGFloat = 20
    
    func viewAnimations(){
        if pickerView.selectedRowInComponent(0) == 0 {
            let basicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            basicAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
            basicAnimation.duration = intDuration
            basicAnimation.fromValue = 1
            basicAnimation.toValue = 0
            basicAnimation.delegate = self
            basicAnimation.name = "POPViewAlpha"
            animView.pop_addAnimation(basicAnimation, forKey: "POPViewAlpha")
        }
        if pickerView.selectedRowInComponent(0) == 1 {
            let basicAnimation = POPBasicAnimation(propertyNamed: kPOPViewBackgroundColor)
            basicAnimation.duration = intDuration
            basicAnimation.fromValue = UIColor.redColor()
            basicAnimation.toValue = UIColor.yellowColor()
            basicAnimation.delegate = self
            basicAnimation.name = "POPViewAlpha"
            animView.pop_addAnimation(basicAnimation, forKey: "POPBackgroundColor")
        }
        if pickerView.selectedRowInComponent(0) == 2 {
            let basicAnimation = POPBasicAnimation(propertyNamed: kPOPViewBounds)
            basicAnimation.duration = intDuration
            basicAnimation.toValue = NSValue(CGRect: CGRectMake(0, 0, 90, 180)) // first 2 values dosent matter
            basicAnimation.delegate = self
            basicAnimation.name = "kPOPViewBounds"
            animView.pop_addAnimation(basicAnimation, forKey: "POPViewBounds")
        }
        if pickerView.selectedRowInComponent(0) == 3 {
            let basicAnimation = POPBasicAnimation(propertyNamed: kPOPViewCenter)
            basicAnimation.duration = intDuration
            basicAnimation.toValue = NSValue(CGPoint: CGPointMake(200, 200))
            basicAnimation.delegate = self
            basicAnimation.name = "kPOPViewCenter"
            animView.pop_addAnimation(basicAnimation, forKey: "POPViewCenter")
        }
        if pickerView.selectedRowInComponent(0) == 4 {
            let basicAnimation = POPBasicAnimation(propertyNamed: kPOPViewFrame)
            basicAnimation.duration = intDuration
            basicAnimation.toValue = NSValue(CGRect: CGRectMake(140, 140, 140, 140))
            basicAnimation.delegate = self
            basicAnimation.name = "kPOPViewFrame"
            animView.pop_addAnimation(basicAnimation, forKey: "POPViewFrame")
        }
        if pickerView.selectedRowInComponent(0) == 5 {
            let basicAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            basicAnimation.duration = intDuration
            basicAnimation.toValue = NSValue(CGSize: CGSizeMake(3, 2))
            basicAnimation.delegate = self
            basicAnimation.name = "kPOPViewScaleXY"
            animView.pop_addAnimation(basicAnimation, forKey: "POPViewScaleXY")
        }
        if pickerView.selectedRowInComponent(0) == 6 {
            let basicAnimation = POPBasicAnimation(propertyNamed: kPOPViewSize)
            basicAnimation.duration = intDuration
            basicAnimation.toValue = NSValue(CGSize: CGSizeMake(30, 200))
            basicAnimation.delegate = self
            basicAnimation.name = "kPOPViewSize"
            animView.pop_addAnimation(basicAnimation, forKey: "POPViewSize")
        }
    }
    
    let animViewValues = ["Alpha",
                     "Background Color",
                     "Size",
                     "Center",
                     "Location & Size",
                     "Size",
                     "Size(Scale)"]
    
    let intDuration:Double = 1
    
    func pop_animationDidStop(anim: POPAnimation!, finished: Bool) {
        if finished{
            if anim.name.containsString("End") {
                return
            }
            if segmentedControl.selectedSegmentIndex == 0 {
            let basicAnimation = anim as! POPBasicAnimation
            basicAnimation.duration = intDuration
            let tempValue = basicAnimation.fromValue
            basicAnimation.fromValue = basicAnimation.toValue
            basicAnimation.toValue = tempValue
            basicAnimation.name = "POPEnd"
            animView.pop_addAnimation(basicAnimation, forKey: "POPEnd")
            }
            else {
                let springAnimation = anim as! POPSpringAnimation
                let tempValue = springAnimation.fromValue
                springAnimation.fromValue = springAnimation.toValue
                springAnimation.toValue = tempValue
                springAnimation.name = "POPEnd"
                animView.layer.pop_addAnimation(springAnimation, forKey: "POPEnd")
            }
        }
    }
    
    //MARK: Picker View
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return animViewValues.count
        }
        else {
            return animLayerValues.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if segmentedControl.selectedSegmentIndex == 0 {
            return animViewValues[row]
        }
        else {
            return animLayerValues[row]
        }
    }
    
    func segmentedControlValueChnaged(sender: AnyObject) {
        pickerView.reloadComponent(0)
    }
}

