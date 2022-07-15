//
//  Animation.swift
//  MangoPlateClone
//
//  Created by Rebecca Ha on 2022/07/11.
//

import UIKit

class CircularTransition: NSObject{
    var circle = UIView()
    var startingPoint = CGPoint.zero{
        didSet{
            circle.center = startingPoint
        }
    }
    var circleColor = UIColor.white
    
    var duration = 0.3
    
    enum CircularTransitionMode:Int{
        case present, dismiss, pop
    }
    
    var transitionMode: CircularTransitionMode = .present
}

extension CircularTransition: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        if transitionMode == .present{
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to){
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circle = UIView()
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations:{
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                    
                    }, completion: {(success: Bool) in
                        transitionContext.completeTransition(success)
                })
            }
        }else{
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to: UITransitionContextViewKey.from
            if let retruningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = retruningView.center
                let viewSize = retruningView.frame.size
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    retruningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    retruningView.center = self.startingPoint
                    retruningView.alpha = 0
                    if self.transitionMode == .pop{
                        containerView.insertSubview(retruningView, belowSubview: retruningView)
                        containerView.insertSubview(self.circle, belowSubview: retruningView)
                    }
                }, completion: {(success: Bool) in
                    retruningView.center = viewCenter
                    retruningView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                })
            }
        }
    }
    
    
    func frameForCircle (withViewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint:CGPoint) -> CGRect{
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offestVector = sqrt(xLength * xLength * 10 + yLength * yLength * 10)
        let size = CGSize(width: offestVector, height: offestVector)
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
}
