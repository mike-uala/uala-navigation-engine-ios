//
//  QuotaProgressBar.swift
//  Uala
//
//  Created by Alejandro Zalazar on 06/06/2019.
//  Copyright © 2019 Ualá. All rights reserved.
//

import UIKit

@IBDesignable
public class FeeProgressBar: UIView {

    @IBInspectable
    var cornerRadius:CGFloat = 0{
        didSet{
            setUPUi()
        }
    }
    
    let paidGradientView:[String : UIColor] = ["startColor" : #colorLiteral(red: 0, green: 0.5803921569, blue: 0.3921568627, alpha: 1) , "endColor" : #colorLiteral(red: 0.2352941176, green: 0.7843137255, blue: 0.5647058824, alpha: 1)]
    let indebGradientView:[String : UIColor] = ["startColor" : #colorLiteral(red: 0.7921568627, green: 0.168627451, blue: 0.168627451, alpha: 1) , "endColor" : #colorLiteral(red: 1, green: 0.4039215686, blue: 0.4, alpha: 1)]
    let pendingGradientView:[String : UIColor] = ["startColor" : #colorLiteral(red: 0.7411764706, green: 0.7607843137, blue: 0.8156862745, alpha: 1) , "endColor" : #colorLiteral(red: 0.8784313725, green: 0.8862745098, blue: 0.9176470588, alpha: 1)]
    
    
    var total: Double = 0
    var indeb: Double = 0
    var paid: Double = 0
    
    var paidBar,indebBar: GradientView!
    
    override public func layoutSubviews() {
        initComponent()
    }
    
    public func setData(paidAmount: Double, indebAmount: Double, totalAmount: Double){
        paid = paidAmount
        indeb = indebAmount
        total = totalAmount
        
        initComponent()
    }

    private func initComponent(){
        removeAllSubviews()
        setUPUi()
        let rect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let gradientView = GradientView(frame: rect)
        gradientView.startColor = #colorLiteral(red: 0.7411764706, green: 0.7607843137, blue: 0.8156862745, alpha: 1)
        gradientView.endColor = #colorLiteral(red: 0.8784313725, green: 0.8862745098, blue: 0.9176470588, alpha: 1)
        gradientView.layer.cornerRadius = cornerRadius
        addSubview(gradientView)
        addProgress(rect: rect)
    }
    
    private func setUPUi(){
        layer.cornerRadius = cornerRadius
    }
    
    func calculatePercentage(value:Double, total: Double) -> Double {
        return value * 100 / total
    }
    
    func calculateWidth(percent: Double, totalWidth: Double) -> Double{
        return percent / 100 * totalWidth
    }
    
    private func addProgress(rect:CGRect){
        var bars: [UIView] = []
        let paidPercentage = calculatePercentage(value : paid,total : total)
        let indebPercentage = calculatePercentage(value : indeb, total: total)
        
        let paidWidth = calculateWidth(percent: paidPercentage, totalWidth: Double(rect.width))
        
        paidBar = GradientView(frame: CGRect(x: 0, y: 0, width: paidWidth, height: Double(rect.height)))
        paidBar.startColor = paidGradientView["startColor"]!
        paidBar.endColor = paidGradientView["endColor"]!
        bars.append(paidBar)
        
        let indebWidth = calculateWidth(percent: indebPercentage, totalWidth: Double(rect.width))
        
        indebBar = GradientView(frame: CGRect(x: paidWidth, y: 0, width: indebWidth, height: Double(rect.height)))
        indebBar.startColor = indebGradientView["startColor"]!
        indebBar.endColor = indebGradientView["endColor"]!
        bars.append(indebBar)
        
        let barsContainer = UIView(frame: rect)
        barsContainer.cornerRadius(radius: 5)
        for bar in bars{
            barsContainer.addSubview(bar)
        }
        
        addSubview(barsContainer)
    }
}

