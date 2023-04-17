import SwiftUI

extension Double {
    func clamped(_ minVal: Double, _ maxVal: Double) -> Double {
        return min(maxVal, max(minVal, self))
    }
}

extension Animation {
    static func matherialEaseInOut(duration: Double) -> Animation {
        return timingCurve(0.4, 0.0, 0.2, 1.0, duration: duration)
    }
    
    static func matherialEaseOut(duration: Double) -> Animation {
        return timingCurve(0.0, 0.0, 0.2, 1.0, duration: duration)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        let shape = RoundedCorner(radius: radius, corners: corners)
        return clipShape(shape)
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
