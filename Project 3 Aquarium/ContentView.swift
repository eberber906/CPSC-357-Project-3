//
//  ContentView.swift
//  Project 3 Aquarium
//
//  Created by Emiliano Berber on 4/27/26.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @GestureState private var offset: CGSize = .zero
    @State private var degrees: Double = 0
    @State private var isRight1 = false
    @State private var isRight2 = false
    @State private var isRight3 = false
    @State private var isRight4 = false
    @State private var lightOn = true

    
    var body: some View {
        let longPress = LongPressGesture(minimumDuration: 1)
            .onEnded{_ in
                print("Long Press")
                lightOn.toggle()
            }
        
        let tap = TapGesture(count: 1)
            .onEnded{_ in
                withAnimation() {
                        degrees += 360
                }
            }
        
        let drag = DragGesture()
            .updating($offset) { dragValue, state, transaction in
                state = dragValue.translation
            }
                
        ZStack {
            Rectangle()
                .fill(lightOn ? Color.blue.gradient:Color.black.gradient)
                .animation(.easeInOut(duration: 1.0), value: Color.blue)
                .ignoresSafeArea()
            Rectangle()
                .fill(Color.white.opacity(lightOn ? 0.3:0))
                .frame(width: 300, height: 2000)
                .offset(y: -500)

            Treasure()
                .offset(offset)
                .gesture(drag)
            Rectangle()
                .fill(Color.brown.gradient)
                .frame(width: 1300, height: 500)
                .offset(y: 700)
                .ignoresSafeArea()
            Circle()
                .fill(lightOn ? Color.white.gradient:Color.gray.gradient)
                .frame(width: 300, height: 300)
                .offset(y: -650)
                .gesture(longPress)
            
            
            VStack{
                Fish()
                .fill(LinearGradient(colors: [.orange, .green], startPoint: .leading, endPoint: .trailing))
                .frame(width: 90, height: 90)
                .rotationEffect(.degrees(degrees))
                .gesture(tap)
                .offset(x: isRight1 ? -600 : 600)
                                .animation(.linear(duration: 5).repeatForever(autoreverses: true), value: isRight1)
                                .onAppear {
                                    isRight1.toggle()
                                }
                Fish()
                .fill(LinearGradient(colors: [.red, .blue], startPoint: .leading, endPoint: .trailing))
                .frame(width: 120, height: 80)
                .rotationEffect(.degrees(degrees))
                .gesture(tap)
                .offset(x: isRight2 ? 600 : 600)
                                .animation(.linear(duration: 1).repeatForever(autoreverses: true), value: isRight2)
                                .onAppear {
                                    isRight2.toggle()
                                }
                Fish()
                .fill(LinearGradient(colors: [.orange, .cyan], startPoint: .leading, endPoint: .trailing))
                .frame(width: 100, height: 90)
                .rotationEffect(.degrees(degrees))
                .gesture(tap)
                .offset(x: isRight3 ? -600 : 600)
                                .animation(.linear(duration: 3).repeatForever(autoreverses: true), value: isRight3)
                                .onAppear {
                                    isRight3.toggle()
                                }
                                
                Fish()
                    .fill(LinearGradient(colors: [.indigo, .mint], startPoint: .leading, endPoint: .trailing))
                    .frame(width: 200, height: 90)
                    .rotationEffect(.degrees(degrees))
                    .gesture(tap)
                    .offset(x: isRight4 ? -600 : 600)
                                    .animation(.easeInOut(duration: 15).repeatForever(autoreverses: true), value: isRight4)
                                    .onAppear {
                                        isRight4.toggle()
                                    }
            }
        }
    }
}

struct Treasure:View{
    var body:some View{
        ZStack{
            Rectangle()
                .fill(Color.brown)
                .frame(width: 250, height: 100)
                .offset(y: 465)
            Rectangle()
                .fill(Color.black.opacity(0.4))
                .frame(width: 250, height: 8)
                .offset(y: 465)
            Rectangle()
                .fill(Color.yellow)
                .frame(width: 30, height: 30)
                .offset(y: 465)
            Circle()
                .fill(Color.black)
                .frame(width: 15, height: 15)
                .offset(y: 460)
            Rectangle()
                .fill(Color.black)
                .frame(width: 5, height: 15)
                .offset(y: 470)
        }
    }
}

struct Fish: Shape{
    func path(in rect: CGRect) -> Path{
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Start at the nose (left middle)
        path.move(to: CGPoint(x: 0, y: height * 0.5))
        
        // Draw top of body
        path.addQuadCurve(
            to: CGPoint(x: width * 0.8, y: height * 0.5),
            control: CGPoint(x: width * 0.4, y: 0)
        )
        
        // Draw tail
        path.addLine(to: CGPoint(x: width, y: height * 0.2))
        path.addLine(to: CGPoint(x: width, y: height * 0.8))
        path.addLine(to: CGPoint(x: width * 0.8, y: height * 0.5))
        
        // Draw bottom of body
        path.addQuadCurve(
            to: CGPoint(x: 0, y: height * 0.5),
            control: CGPoint(x: width * 0.4, y: height)
        )
        return path
    }
}

#Preview {
    ContentView()
}
