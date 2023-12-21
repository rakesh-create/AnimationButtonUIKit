//
//  ViewController.swift
//  AnimationButtonUIKit
//
//  Created by Rakesh on 11/09/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mybutton: FTMicroInteractionButtonStyle!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(resource: .viewcolor)
        FTMicroInteractionButtonStyle.shared.apply(to: mybutton)

        // Do any additional setup after loading the view.
    }


}
open class FTUIkitInteractionButton: UIButton {

    private var isBouncing: Bool = false
    private let animationDuration: Double = 0.2

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    private func commonInit() {
        addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        addTarget(self, action: #selector(buttonTouchUpInside), for: .touchUpInside)
    }
    @objc private func buttonTouchDown() {
        animateButton(scale: 0.97)
        print("buttonTouchDown")
    }
    @objc private func buttonTouchUpInside() {
        animateButton(scale: 1.0)
        print("buttonTouchUpInside")
    }

    private func animateButton(scale: CGFloat) {
        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
        springAnimation.fromValue = layer.presentation()?.value(forKeyPath: "transform.scale") as? CGFloat ?? 1.0
        springAnimation.toValue = scale
        springAnimation.duration = animationDuration
//        springAnimation.initialVelocity = 0.3
//        springAnimation.damping = 0.1
        layer.add(springAnimation, forKey: "springAnimation")
        UIView.animate(withDuration: animationDuration) {
            self.isBouncing = scale < 1.0
        }
    }
}


class FTMicroInteractionButtonStyle : UIButton{
    static let shared = FTMicroInteractionButtonStyle()
    let scaleValue: CGFloat = 0.9


    func apply(to button: UIButton) {
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchDown)
        button.addTarget(self, action: #selector(buttonReleased(sender:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonReleased(sender:)), for: .touchUpOutside)
    }

    @objc private func buttonPressed(sender: UIButton) {
        print("Pressed")
        UIView.animate(withDuration: 0.3, animations: {
            sender.transform = CGAffineTransform(scaleX: self.scaleValue, y: self.scaleValue)
        })
    }

    @objc private func buttonReleased(sender: UIButton) {
        print("Released")
        UIView.animate(withDuration: 0.3, animations: {
            sender.transform = .identity
        })
    }
}

