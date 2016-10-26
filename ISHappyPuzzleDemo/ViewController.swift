//
//  ViewController.swift
//  ISHappyPuzzleDemo
//
//  Created by isaced on 2016/10/26.
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var puzzleView = ISHappyPuzzleView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        puzzleView.backgroundColor = .black
        self.view.addSubview(puzzleView)
        self.view.bringSubview(toFront: self.segmentedControl)
        
        puzzle(1)
    }
    
    func puzzle(_ n: Int) {
        if let layout = layoutInfo(n) {
            self.puzzleView.loadLayout(layout, config: { (index, imageView) in
                    imageView.image = UIImage(named: "\(index).jpg")
                    for subv in imageView.subviews { subv.removeFromSuperview() }
                }, complate: { 
                    // last photo effect
                    if let lastView = self.puzzleView.subviews.last {
                        let mask = UIView(frame: lastView.bounds)
                        mask.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                        lastView.addSubview(mask)
                        
                        let label = UILabel(frame: CGRect(x: 20, y: 0, width: lastView.bounds.width - 40, height: lastView.bounds.height))
                        label.text = "我上传了几张照片在《海南之旅》"
                        label.textAlignment = .center
                        label.textColor = .white
                        label.numberOfLines = 0
                        label.font = UIFont.systemFont(ofSize: 12.0)
                        lastView.addSubview(label)
                    }
            })
        }
        
    }
    
    func layoutInfo(_ index: Int) -> [[String : Float]]? {
        if let jsonFilePath = Bundle.main.path(forResource: "\(index)", ofType: "json") {
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonFilePath)) {
                return (try? JSONSerialization.jsonObject(with: jsonData)) as? [[String : Float]]
            }
        }
        return nil
    }
    
    @IBAction func layoutChange(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.2) { 
            self.puzzle(sender.selectedSegmentIndex)
        }
    }
}

