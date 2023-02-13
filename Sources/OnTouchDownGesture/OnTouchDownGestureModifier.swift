//
//  OnTouchDownGestureModifier.swift
//  
//
//  Created by SwiftMan on 2023/02/13.
//

import SwiftUI

extension View {
  public func onTouchDownGesture(count: Int = 1,
                                 coordinateSpace: CoordinateSpace = .local,
                                 perform action: @escaping (CGPoint) -> Void) -> some View {
    modifier(OnTouchDownGestureModifier(count: count,
                                        coordinateSpace: coordinateSpace,
                                        perform: action))
  }
}

public struct OnTouchDownGestureModifier: ViewModifier {
  @State
  private var isTapped = false
  
  @State
  private var tapCount = 0
  
  private let count: Int
  private let coordinateSpace: CoordinateSpace
  private let perform: (CGPoint) -> Void
  
  public init(count: Int = 1,
              coordinateSpace: CoordinateSpace = .local,
              perform: @escaping (CGPoint) -> Void) {
    self.count = count
    self.coordinateSpace = coordinateSpace
    self.perform = perform
  }
  
  public func body(content: Content) -> some View {
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
