//
//  ContentView.swift
//  YTSubscribeAnimation
//
//  Created by Everton Carneiro on 08/09/21.
//

import SwiftUI

struct ContentView: View {
    @State private var likes = 2999
    @State private var likeColor = Color.gray
    @State private var likeClicked = false
    
    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 20.0) {
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
                    .foregroundColor(likeClicked ? Color.blue : Color.gray)
                    .animation(.default)
                    Button(action: {}, label: {
                        Text("SUBSCRIBE")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .foregroundColor(Color.white)
                            .background(Color("red"))
                            .cornerRadius(8)
                    })
                }
                .padding(.horizontal, 20)
                .padding(.bottom)
                .padding(.top, 25)
                .background(Color.white)
                .cornerRadius(8)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)


        }
        .background(Color.yellow)
        .edgesIgnoringSafeArea(.all)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
