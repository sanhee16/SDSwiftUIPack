//
//  File.swift
//
//
//  Created by Sandy on 7/19/24.
//

import Foundation
import SwiftUI
import UIKit

//MARK: Font
public extension View {
    func sdFont(_ font: Font, color: Color) -> some View {
        if #available(iOS 15.0, *) {
            return self.font(font).foregroundStyle(color)
        } else {
            return self.font(font).foregroundColor(color)
        }
    }
}

//MARK: Padding
public extension View {
    func sdPaddingpadding(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> some View {
        return self.padding(EdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing))
    }
    func sdPaddingTop(_ value: CGFloat) -> some View {
        return self.padding(EdgeInsets(top: value, leading: 0, bottom: 0, trailing: 0))
    }
    func sdPaddingLeading(_ value: CGFloat) -> some View {
        return self.padding(EdgeInsets(top: 0, leading: value, bottom: 0, trailing: 0))
    }
    func sdPaddingTrailing(_ value: CGFloat) -> some View {
        return self.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: value))
    }
    func sdPaddingBottom(_ value: CGFloat) -> some View {
        return self.padding(EdgeInsets(top: 0, leading: 0, bottom: value, trailing: 0))
    }
    func sdPaddingHorizontal(_ value: CGFloat) -> some View {
        return self.padding(EdgeInsets(top: 0, leading: value, bottom: 0, trailing: value))
    }
    func sdPaddingVertical(_ value: CGFloat) -> some View {
        return self.padding(EdgeInsets(top: value, leading: 0, bottom: value, trailing: 0))
    }
}

//MARK: Frame
public extension View {
    func frame(both: CGFloat, alignment: Alignment = .center) -> some View {
        return self.frame(width: both, height: both, alignment: alignment)
    }
}

//MARK: skeleton
public extension View {
    func skeleton(_ isLoading: Bool, reason: RedactionReasons) -> some View {
        self.redacted(reason: isLoading ? .placeholder : [])
    }
}

//MARK: Keyboard
public extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//MARK: rectReader
public extension View {
    func rectReader(_ binding: Binding<CGRect>, in space: CoordinateSpace) -> some View {
        self.background(GeometryReader { (geometry) -> AnyView in
            let rect = geometry.frame(in: space)
            DispatchQueue.main.async {
                binding.wrappedValue = rect
            }
            return AnyView(Rectangle().fill(Color.clear))
        })
    }
}

//MARK: RoundedCorner
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
