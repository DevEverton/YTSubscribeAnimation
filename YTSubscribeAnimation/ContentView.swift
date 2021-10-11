//
//  ContentView.swift
//  YTSubscribeAnimation
//
//  Created by Everton Carneiro on 08/09/21.
//

import SwiftUI
//Test

struct ContentView: View {
    @State private var likes = 2999
    @State private var likeColor = Color.gray
    @State private var likeClicked = false
    @State private var subscribed = false
    @State private var notificationActive = false
    @State private var bellSize: CGFloat = 40
    @State var invalidAttempts = 0

    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading, spacing: 20.0) {
                    HStack {
                        Button(action: {
                            if likeClicked {
                                likes -= 1
                            } else {
                                likes += 1
                            }
                            likeClicked.toggle()
                        }, label: {
                            Image(likeClicked ? "like-blue" : "like")
                                .resizable()
                                .frame(width: 32, height: 32)
                        })
                        Text("\(likes)")
                            .font(.system(size: 20, weight: .medium, design: .rounded))
                    }
                    .padding(.leading)
                    .foregroundColor(likeClicked ? Color.blue : Color.gray)
                    .animation(.default)
                    HStack(spacing: 20.0) {
                        Button(action: {
                            subscribed.toggle()
                        }, label: {
                            Text(subscribed ? "SUBSCRIBED" : "SUBSCRIBE")
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .rotation3DEffect(subscribed ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: 10, y: 0, z: 0))
           
                        })
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .foregroundColor(subscribed ? Color.gray : Color.white)
                        .background(subscribed ? Color(.systemGray5) : Color("red"))
                        .cornerRadius(8)
                        .rotation3DEffect(subscribed ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: 10, y: 0, z: 0))
                        
                        Button(action: {
                            notificationActive.toggle()
                            invalidAttempts += 1
                            vibrate()
                        }, label: {
                            Image(notificationActive ? "bell-ring" : "bell")
                                .resizable()
                                .frame(width: subscribed ? bellSize : 0, height: subscribed ? bellSize : 0)
                                .rotation3DEffect(subscribed ? Angle(degrees: 360): Angle(degrees: 0), axis: (x: 0, y: 0, z: 10))
                                .padding(.trailing, 15)
                                .modifier(ShakeEffect(shakes: invalidAttempts * 1))
                                
                        })
                    }
                }
                .padding(.leading, 30)
                .padding(.bottom)
                .padding(.top, 25)
                .background(Color.white)
                .cornerRadius(8)
                .animation(.default)
                .shadow(radius: 2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .background(Color.yellow)
        .edgesIgnoringSafeArea(.all)
    }
    
    func vibrate() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ShakeEffect: GeometryEffect {
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: -10 * sin(position * 2 * .pi), y: 0))
    }
    
    init(shakes: Int) {
        position = CGFloat(shakes)
    }
    
    var position: CGFloat
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
}
