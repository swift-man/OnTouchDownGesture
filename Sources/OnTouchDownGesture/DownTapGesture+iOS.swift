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
  func makeUIView(context: Context) -> UIView {
    let view = UIView()
    let gesture = UITouchDownGestureRecognizer(
      target: downTapCoordniator,
      action: #selector(downTapCoordniator.tapped(sender:))
    )
    view.addGestureRecognizer(gesture)
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {}
}

extension DownTapCoordniator {
  @objc
  func tapped(sender: UITouchDownGestureRecognizer) {
    if sender.state == .ended {
      let point = sender.location(in: sender.view)
      performAction?(point)
    }
  }
}

fileprivate final class UITouchDownGestureRecognizer: UIGestureRecognizer {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
    if self.state == .possible {
      self.state = .recognized
    }
  }
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
    self.state = .failed
  }
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
    self.state = .failed
  }
}

#endif
