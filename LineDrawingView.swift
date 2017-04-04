//
//  LineDrawingView.swift
//  FHLB
//
//  Created by Jayachandra Agraharam on 03/04/17.
//  Copyright © 2017 Opteamix India Business Solutions Pvt Ltd. All rights reserved.
//

import UIKit

@IBDesignable
class LineDrawingView: UIView {

    var paths = [UIBezierPath]()
    var currentPath: UIBezierPath!
    var startPoint: CGPoint!
    var isTouchEnded = false
    
    @IBInspectable var lineColor:UIColor = UIColor.black
    
    @IBInspectable var lineWidth:CGFloat = 3.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isMultipleTouchEnabled = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isMultipleTouchEnabled = true
    }

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        lineColor.setStroke()
        for path in paths {
            path.stroke()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        startPoint = touch?.location(in: self)
        currentPath = UIBezierPath()
        currentPath.lineWidth = lineWidth
        paths.append(currentPath)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        currentPath.removeAllPoints()
        currentPath.move(to: startPoint)
        if let p = touch?.location(in: self){
            currentPath.addLine(to: p)
            if isTouchEnded {
                //Distance = √(x2−x1)2+(y2−y1)2
                let squares = (p.x-startPoint.x)*(p.x-startPoint.x) + (p.y-startPoint.y)*(p.y-startPoint.y);
                let distance = sqrtf(Float(squares));
                print("Distance ## \(distance)")
            }
        }
        isTouchEnded = false
        self.setNeedsDisplay()
    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouchEnded = true
        self.touchesMoved(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesEnded(touches, with: event)
    }
    
    func undo(){
        self.setNeedsDisplay()
        paths.removeLast()
    }
    
}
