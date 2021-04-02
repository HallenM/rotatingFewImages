//
//  ViewController.swift
//  app02.2.0
//
//  Created by developer on 05.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var speedField: UITextField?
    @IBOutlet var radiusField: UITextField?
    @IBOutlet var nPicturesField: UITextField?
    @IBOutlet var btnRotation: UIButton?
    
    var isRotating = true
    var timer = Timer()
    var imageList = [UIImageView]()
    var angle = [Float]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc func calcRotation() {
        let sizeScreeen = UIScreen.main.bounds
        let centerX = sizeScreeen.width / 2
        let centerY = sizeScreeen.height / 2
        
        let speedStr: String? = speedField?.text
        let radiusStr: String? = radiusField?.text
        let nPicturesStr: String? = nPicturesField?.text
        
        if let speedStr = speedStr, let speed = Float(speedStr),
           let radiusStr = radiusStr, let radius = Float(radiusStr),
           let nPicturesStr = nPicturesStr, let nPictures = Int(nPicturesStr) {
            
            addOrDelImg(nPictrs: nPictures)
            var i = 0
            for image in imageList {
                if angle[i] == 360 {
                    angle[i] = 0
                }
                
                let cosValue = CGFloat(cos(angle[i] * .pi / 180))
                let sinValue = CGFloat(sin(angle[i] * .pi / 180))
                image.center.x = CGFloat(radius) * cosValue + centerX
                image.center.y = CGFloat(radius) * sinValue + centerY
                
                angle[i] += 5 * speed// + Float(i * 10)
                i += 1
            }
        }
    }
    
    func addOrDelImg(nPictrs: Int){        
        let image = UIImage(named: "cat.jpg")
        if imageList.count < nPictrs {
            var i = 0
            while imageList.count != nPictrs {
                let imageView = UIImageView()
                imageView.frame = CGRect(x: 120 * i + 15, y: 200 + i * 10, width: 125, height: 160)
                imageView.contentMode = UIView.ContentMode.scaleAspectFit
                imageView.image = image
                
                imageList.append(imageView)
                self.view.addSubview(imageView)
                changeAngle(nPictrs: nPictrs)
                i += 1
            }
        } else if imageList.count > nPictrs {
            while imageList.count != nPictrs {
                imageList[imageList.count - 1].removeFromSuperview()
                imageList.removeLast()
                changeAngle(nPictrs: nPictrs)
                }
        }
    }
    
    func changeAngle(nPictrs: Int) {
        let coefficient: Float = 360 / Float(nPictrs)
        angle.removeAll()
        angle.append(0)
        for i in 1..<nPictrs {
            angle.append(angle[i - 1] + coefficient)
        }
    }

    @IBAction func doRotation() {
        if isRotating == true {
            btnRotation?.setTitle("Stop", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(calcRotation), userInfo: nil, repeats: true)
            
        } else {
            btnRotation?.setTitle("Start", for: .normal)
            timer.invalidate()
        }
        isRotating = !isRotating
    }



}

