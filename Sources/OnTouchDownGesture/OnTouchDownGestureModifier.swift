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
  ///    - coordinateSpace: The coordinate space in which to receive
  ///      location values. Defaults to ``CoordinateSpace/local``.
  ///    - action: The action to perform. This closure receives an input
  ///      that indicates where the interaction occurred.
  @available(iOS 13.0, macOS 10.15, watchOS 6.0, *)
  @available(tvOS, unavailable)
  public func onTouchDownGesture(coordinateSpace: CoordinateSpace = .local,
                                 perform action: @escaping (CGPoint) -> Void) -> some View {
    modifier(OnTouchDownGestureModifier(coordinateSpace: coordinateSpace,
                                        perform: action))
  }
}

fileprivate struct OnTouchDownGestureModifier: ViewModifier {
  @State
  private var isTapped = false
  
  private let coordinateSpace: CoordinateSpace
  private let perform: (CGPoint) -> Void
  
  fileprivate init(coordinateSpace: CoordinateSpace = .local,
                   perform: @escaping (CGPoint) -> Void) {
    self.coordinateSpace = coordinateSpace
    self.perform = perform
  }
  
  fileprivate func body(content: Content) -> some View {
    content
      .gesture(DragGesture(minimumDistance: 0,
                           coordinateSpace: coordinateSpace)
        .onChanged { touch in
          guard !self.isTapped else { return }
          
          self.isTapped = true
          self.perform(touch.location)
        }
        .onEnded { _ in
          self.isTapped = false
        })
      .disabled(isTapped)
  }
}
