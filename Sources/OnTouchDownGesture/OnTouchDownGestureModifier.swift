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
  /// Use this method to perform the specified `action` when the user clicks
  /// or taps on the modified view `count` times. The action closure receives
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
  ///    - count: The number of taps or clicks required to trigger the action
  ///      closure provided in `action`. Defaults to `1`.
  ///    - coordinateSpace: The coordinate space in which to receive
  ///      location values. Defaults to ``CoordinateSpace/local``.
  ///    - action: The action to perform. This closure receives an input
  ///      that indicates where the interaction occurred.
  public func onTouchDownGesture(count: Int = 1,
                                 coordinateSpace: CoordinateSpace = .local,
                                 perform action: @escaping (CGPoint) -> Void) -> some View {
    modifier(OnTouchDownGestureModifier(count: count,
                                        coordinateSpace: coordinateSpace,
                                        perform: action))
  }
}

fileprivate struct OnTouchDownGestureModifier: ViewModifier {
  @State
  private var isTapped = false
  
  @State
  private var tapCount = 0
  
  private let count: Int
  private let coordinateSpace: CoordinateSpace
  private let perform: (CGPoint) -> Void
  
  fileprivate init(count: Int = 1,
              coordinateSpace: CoordinateSpace = .local,
              perform: @escaping (CGPoint) -> Void) {
    self.count = count
    self.coordinateSpace = coordinateSpace
    self.perform = perform
  }
  
  fileprivate func body(content: Content) -> some View {
    content
      .simultaneousGesture(DragGesture(minimumDistance: 0,
                                       coordinateSpace: coordinateSpace)
        .onChanged { touch in
          tapCount += 1
          
          if count == tapCount {
            if !self.isTapped {
              self.isTapped = true
              self.perform(touch.location)
            }
          }
        }
        .onEnded { _ in
          self.isTapped = false
        })
  }
}
