//
//  File.swift
//  
//
//  Created by SwiftMan on 2023/02/21.
//

import SwiftUI
#if os(iOS)
import UIKit

extension DownTapGesture: UIViewRepresentable {
  internal func makeUIView(context: Context) -> UIView {
    let view = UIView()
    let gesture = UITouchDownGestureRecognizer(
      target: downTapCoordniator,
      action: #selector(downTapCoordniator.tapped(sender:))
    )
    view.addGestureRecognizer(gesture)
    return view
  }
  
  internal func updateUIView(_ uiView: UIView, context: Context) {}
}

extension DownTapCoordniator {
  @objc
  internal func tapped(sender: UITouchDownGestureRecognizer) {
    if sender.state == .ended {
      performAction?()
    }
  }
}

internal final class UITouchDownGestureRecognizer: UIGestureRecognizer {
  internal override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
    if self.state == .possible {
      self.state = .recognized
    }
  }
  internal override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
    self.state = .failed
  }
  internal override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
    self.state = .failed
  }
}

#endif
