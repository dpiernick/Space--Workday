//
//  StarView.swift
//  Space!
//
//  Created by Dave Piernick on 4/18/23.
//

import Foundation
import UIKit

class StarView: UIView {
    
    var pulseDuration = Double.random(in: 0.5...2)
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        let initialSize = Int.random(in: 1...3)
        self.frame = CGRect(x: 0, y: 0, width: initialSize, height: initialSize)
        self.layer.cornerRadius = self.frame.size.height/2
        backgroundColor = .white
        
        pulse()
    }
    
    func pulse() {
        UIView.animate(withDuration: self.pulseDuration) {
            self.transform = CGAffineTransform(scaleX: 2, y: 2)
        } completion: { _ in
            UIView.animate(withDuration: self.pulseDuration) {
                self.transform = .identity
            } completion: { _ in
                self.pulse()
            }
        }
    }
}
