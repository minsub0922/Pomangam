//
//  UIViewAnimation+.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/10/25.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

extension UIView {
    public func bounce() {
        var targetFrame = self.frame
        targetFrame.origin.y -= 3
        self.frame = targetFrame
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseOut,
                       animations: {
            targetFrame.origin.y += 3
            self.frame = targetFrame
        }, completion: nil)
    }
    
    public func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y-10))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y+10))

        self.layer.add(animation, forKey: "position")
    }
    
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 2
        rotation.isCumulative = true
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func tick() {
        UIView.animateKeyframes(withDuration: 0.6,
                                delay: 0.1,
                                options: [.calculationModeCubic],
                                animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/4) {
                self.rotate(to: CGFloat(Double.pi*0.1))
            }
            UIView.addKeyframe(withRelativeStartTime: 1/4, relativeDuration: 1/4) {
                self.rotate(to: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 2/4, relativeDuration: 1/4) {
                self.rotate(to: -CGFloat(Double.pi*0.1))
            }
            UIView.addKeyframe(withRelativeStartTime: 3/4, relativeDuration: 1/4) {
                self.rotate(to: 0)
            }
        }, completion: { _ in
            UIView.animateKeyframes(withDuration: 0.4,
                                    delay: 0,
                                options: [.calculationModeCubic],
                                animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/4) {
                    self.rotate(to: CGFloat(Double.pi*0.07))
                }
                UIView.addKeyframe(withRelativeStartTime: 1/4, relativeDuration: 1/4) {
                    self.rotate(to: 0)
                }
                UIView.addKeyframe(withRelativeStartTime: 2/4, relativeDuration: 1/4) {
                    self.rotate(to: -CGFloat(Double.pi*0.07))
                }
                UIView.addKeyframe(withRelativeStartTime: 3/4, relativeDuration: 1/4) {
                    self.rotate(to: 0)
                }
            }, completion: nil)
        })
    }
    
    private func rotate(to: CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: to)
    }
}
