//
//  ContentView.swift
//  SlopeColorChageEffect
//
//  Created by 本田輝 on 2024/06/23.
//

import SwiftUI

struct ChangeColorModifier: ViewModifier {
    @ObservedObject var manager: MotionManager
    
    func body(content: Content) -> some View {
        content
            .colorEffect(ShaderLibrary.slopeSeppenImage(.float(Float(manager.pitch)),.float(Float(manager.roll))))
    }
}

extension View {
    func colorChangeEffect(manager: MotionManager) -> some View {
        modifier(ChangeColorModifier(manager: manager))
    }
}

struct ContentView: View {
    @State var motionManager = MotionManager()
    var body: some View {
        VStack {
            Image(systemName: "heart.fill")
                .imageScale(.large)
                .foregroundStyle(.pink)
                .foregroundStyle(.tint)
                .colorChangeEffect(manager: motionManager)
            Text("Hello, world!")
        }
        .padding()
    }
}
