//
//  ISHappyPuzzleView.swift
//  ISHappyPuzzleDemo
//
//  Created by isaced on 2016/10/26.
//
//

import UIKit

typealias ISHappyPuzzleViewLayoutConfig = (Int, UIImageView) -> Swift.Void

class ISHappyPuzzleView : UIView {
    
    var imageViewPool: Set<UIImageView> = Set()
    
    func loadLayout(_ layout: [[String:Float]], config: ISHappyPuzzleViewLayoutConfig? = nil, complate: (()->())? = nil) {
        
        let puzzleWidth = bounds.width
        let puzzleHeight = bounds.height
        
        var tempPool = imageViewPool
        
        var i = 0
        for tile in layout{
            let x = CGFloat(tile["x"]!) * CGFloat(puzzleWidth)
            let y = CGFloat(tile["y"]!) * CGFloat(puzzleHeight)
            let width = CGFloat(tile["width"]!) * CGFloat(puzzleWidth)
            let height = CGFloat(tile["height"]!) * CGFloat(puzzleHeight)
            
            let rect = CGRect(x: x, y: y, width: width, height: height)
            let v =  tempPool.popFirst() ?? UIImageView(frame: CGRect(origin: rect.origin, size: .zero))
            v.frame = rect
            if v.superview == nil {
                v.backgroundColor = .gray
                v.contentMode = .scaleAspectFill
                v.clipsToBounds = true
                addSubview(v)
                imageViewPool.insert(v)
            }
            
            config?(i, v)
            
            i = i + 1
        }
        
        imageViewPool.subtract(tempPool)
        for v in tempPool {
            v.removeFromSuperview()
        }
        
        complate?()
    }
    
    func screenShot() -> UIImage? {
        guard frame.size.height > 0 && frame.size.width > 0 else {
            return nil
        }
        
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        let image = renderer.image { ctx in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        return image
    }
}
