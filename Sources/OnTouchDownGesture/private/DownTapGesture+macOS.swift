//
//  DownTapGesture+macOS.swift.swift
//  
//
//  Created by SwiftMan on 2023/02/21.
//

import SwiftUI
#if os(macOS)
import Cocoa

extension DownTapGesture: NSViewRepresentable {
  internal func makeNSView(context: Context) -> NSView {
    let button = NSButton()
    
    button.target = downTapCoordniator
    button.action = #selector(downTapCoordniator.tapped(sender:))
    button.setButtonType(.momentaryChange)
    button.sendAction(on: .leftMouseDown)
    
    return button
  }
  
  internal func updateNSView(_ nsView: NSView, context: Context) {}
}

extension DownTapCoordniator {
  @objc
  internal func tapped(sender: NSButton) {
    performAction?()
  }
}

#endif
