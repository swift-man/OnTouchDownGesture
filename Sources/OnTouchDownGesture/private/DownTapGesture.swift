//
//  DownTapGesture.swift
//  
//
//  Created by SwiftMan on 2023/02/22.
//

import SwiftUI

internal struct OnTouchDownGestureModifier: ViewModifier {
  private let perform: (CGPoint) -> Void
  
  internal init(perform: @escaping (CGPoint) -> Void) {
    self.perform = perform
  }
  
  internal func body(content: Content) -> some View {
    content
      .overlay(content: {
        DownTapGesture(performAction: perform)
      })
  }
}

internal struct DownTapGesture {
  internal let performAction: (CGPoint) -> Void
  internal let downTapCoordniator = DownTapCoordniator()
  
  internal func makeCoordinator() -> DownTapCoordniator {
    downTapCoordniator.performAction = performAction
    return downTapCoordniator
  }
}

internal final class DownTapCoordniator {
  var performAction: ((CGPoint) -> Void)?
}
