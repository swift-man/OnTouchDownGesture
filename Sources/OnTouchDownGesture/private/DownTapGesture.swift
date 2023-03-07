//
//  DownTapGesture.swift
//  
//
//  Created by SwiftMan on 2023/02/22.
//

import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
internal struct DownTapGestureModifier: ViewModifier {
  private let perform: () -> Void
  
  internal init(perform: @escaping () -> Void) {
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
  internal let performAction: () -> Void
  internal let downTapCoordniator = DownTapCoordniator()
  
  internal func makeCoordinator() -> DownTapCoordniator {
    downTapCoordniator.performAction = performAction
    return downTapCoordniator
  }
}

internal final class DownTapCoordniator {
  var performAction: (() -> Void)?
}
