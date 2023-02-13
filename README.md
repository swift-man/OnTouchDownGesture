# OnTouchDownGesture
SwiftUI Down Tapped

![Badge](https://img.shields.io/badge/swift-white.svg?style=flat-square&logo=Swift)
![Badge](https://img.shields.io/badge/SwiftUI-001b87.svg?style=flat-square&logo=Swift&logoColor=black)
![Badge - Version](https://img.shields.io/badge/Version-0.5.0-1177AA?style=flat-square)
![Badge - Swift Package Manager](https://img.shields.io/badge/SPM-compatible-orange?style=flat-square)
![Badge - Platform](https://img.shields.io/badge/platform-mac_10_15|ios_13|watchos_6-yellow?style=flat-square)
![Badge - License](https://img.shields.io/badge/license-MIT-black?style=flat-square)  
---

```
struct DownTapGestureExample: View {
  @State private var location: CGPoint = .zero
  
  var body: some View {
    Circle()
      .fill(self.location.y > 50 ? Color.blue : Color.red)
      .frame(width: 100, height: 100, alignment: .center)
      .onTouchDownGesture { location in
        self.location = location
      }
  }
}
```
