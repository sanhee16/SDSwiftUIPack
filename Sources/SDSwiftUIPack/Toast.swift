//
//  File.swift
//  
//
//  Created by sandy on 8/1/24.
//

import Foundation
import SwiftUI

extension View {
    func toast(
        isPresented: Binding<Bool>,
        presentMessage: String
    ) -> some View {
        self.modifier(
           Toast(isPresented: isPresented, presentMessage: presentMessage)
       )
    }
}

struct Toast: ViewModifier {
    var isPresented: Binding<Bool>
    var presentMessage: String
    
    func body(content: Content) -> some View {
        return content
            .overlay(
                overlayView: ToastView.init(title: presentMessage, show: isPresented),
                show: isPresented
            )
    }
}


struct ToastView: View {
    let title: String
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text(title)
                .font(.sys16r)
                .foregroundColor(.white)
                .sdPadding(top: 10, leading: 20, bottom: 10, trailing: 20)
                .background(Color(hex: "#252525").opacity(0.82))
                .clipShape(Capsule())
                .offset(y: -16)
                .zIndex(100)
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 40)
        .onDisappear(perform: {
            self.show = false
        })
    }
}


struct Overlay<T: View>: ViewModifier {
    @Binding var show: Bool
    let overlayView: T
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                overlayView
            }
        }
    }
}

extension View {
    func overlay<T: View>( overlayView: T, show: Binding<Bool>) -> some View {
        self.modifier(Overlay.init(show: show, overlayView: overlayView))
    }
}
