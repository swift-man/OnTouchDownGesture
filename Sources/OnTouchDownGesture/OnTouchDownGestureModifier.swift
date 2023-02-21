//
//  OnTouchDownGestureModifier.swift
//  
//
//  Created by SwiftMan on 2023/02/13.
//

import SwiftUI

extension View {
  /// Adds an action to perform when this view recognizes a tap gesture,
  /// and provides the action with the location of the interaction.
  ///
  /// The action closure receives
  /// the location of the interaction.
  ///
  /// > Note: If you create a control that's functionally equivalent
  /// to a ``Button``, use ``ButtonStyle`` to create a customized button
  /// instead.
  ///
  /// The following code adds a tap gesture to a ``Circle`` that toggles the color
  /// of the circle based on the tap location.
  ///
  ///     struct DownTapGestureExample: View {
  ///         @State private var location: CGPoint = .zero
  ///
  ///         var body: some View {
  ///             Circle()
  ///                 .fill(self.location.y > 50 ? Color.blue : Color.red)
  ///                 .frame(width: 100, height: 100, alignment: .center)
  ///                 .onTouchDownGesture { location in
  ///                     self.location = location
  ///                 }
  ///         }
  ///     }
  ///
  /// - Parameters:
  ///    - action: The action to perform. This closure receives an input
  ///      that indicates where the interaction occurred.
  @available(iOS 13.0, macOS 12.0, *)
  @available(watchOS, unavailable)
  @available(tvOS, unavailable)
  public func onTouchDownGesture(perform action: @escaping (CGPoint) -> Void) -> some View {
    modifier(OnTouchDownGestureModifier(perform: action))
  }
}

fileprivate struct OnTouchDownGestureModifier: ViewModifier {
  private let perform: (CGPoint) -> Void
  
  fileprivate init(perform: @escaping (CGPoint) -> Void) {
    self.perform = perform
  }
  
  fileprivate func body(content: Content) -> some View {
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
