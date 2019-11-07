//
//  ProgressVIew.swift
//  Airpod
//
//  Created by Burns on 7/11/19.
//  Copyright © 2019 Group 6. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    private var backgroundLayer = CAShapeLayer()
    private var frontLayer = CAShapeLayer()
    private var textLayer = CATextLayer()
    private var number = Double()
    private var defaultNum = Double()
    
    public var progress: CGFloat = 0 {
        didSet{
            didProgressUpdated()
        }
    }
    
    func getNumber(AQIData: Double)
    {
        self.number = AQIData
    }
    
    override func draw(_ rect: CGRect) {
        
        //MARK: Set a gray background circle
        backgroundLayer = createCircleLayer(rect: rect, strokeColor: UIColor.lightGray.cgColor, fillColor: UIColor.lightGray.cgColor, lineWidth: 20)
        
        //MARK: Set a circle here
        frontLayer = createCircleLayer(rect: rect, strokeColor: UIColor.red.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: 20)
        //MARK: Set the center font
        textLayer = cteateTextLayer(rect: rect, textColor: UIColor.orange.cgColor)
       
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(frontLayer)
        layer.addSublayer(textLayer)

    }
    
    private func createCircleLayer(rect: CGRect, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer
    {
        let width = rect.width
        let height = rect.height
        
        let center = CGPoint(x: width / 2, y: height / 2)
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 150, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        
        return shapeLayer
    }
    
    private func cteateTextLayer(rect: CGRect, textColor: CGColor) -> CATextLayer
    {
        let width = rect.width
        let height = rect.height
        
        let fontSize = (min(width, height) / 4)
        let offset = min(width, height) * 0.1
        
        let layer = CATextLayer()
        layer.string = "\(number)"
        layer.backgroundColor = UIColor.clear.cgColor
        layer.foregroundColor = textColor
        layer.fontSize = fontSize
        layer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width, height: fontSize + offset)
        layer.alignmentMode = .center
        
        return layer
        
    }
    
    private func didProgressUpdated(){
        textLayer.string = "\(number)"
        frontLayer.strokeEnd = progress
    }


        

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
