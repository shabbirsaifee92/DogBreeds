//
//  ContentView.swift
//  Dog Breed
//
//  Created by Shabbir Saifee on 8/1/20.
//  Copyright © 2020 Shabbir Saifee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var defaults = UserDefaults.standard
    @State private var topPrediction = ""
    @State private var secondPrediction = ""
    @State private var topConfidence = ""
    @State private var secondConfidence = ""
    
    @State private var image: Image? = nil
    @State private var placeHolderIsShown = true
    @State private var showImagePicker = false
    
    var body: some View {
        VStack {
            VStack {
                //title
                Text("Dog Breed ID")
                    .font(.custom("Charter Italic", size: 34))
                    .foregroundColor(.white)
            }
            .padding(.bottom)
            
            //placeholder and user selected image
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(UIColor.systemOrange), lineWidth: 4)
                        .frame(width: 350, height: 250)
                    //this user selected image will go here
                    image?
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    if placeHolderIsShown {
                        Image("dogPlaceholder")
                            .scaleEffect(0.7)
                            .cornerRadius(20)
                            .shadow(color: .white, radius: 3)
                        
                    } else {
                        Image("dogPlaceholder")
                            .frame(width: 500, height: 200)
                            .hidden()
                    }
                    
                }
            }
            
            Spacer()
            
            //PREDICTION LABELS
            VStack {
                Text("Top Prediction & Confidence:")
                    .font(.custom("Charter Italic", size: 22))
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(UIColor.systemPink), lineWidth: 2)
                    .frame(width: 350, height: 60)
                    .overlay(
                        Text("\(topPrediction) \(topConfidence)")
                            .padding(5)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .font(.title)
                )
                    .padding(.bottom)
                
                Text("Second Prediction & Confidence:")
                    .font(.custom("Charter Italic", size: 22))
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(UIColor.systemPink), lineWidth: 2)
                    .frame(width: 350, height: 60)
                    .overlay(
                        Text(" \(secondPrediction) \(secondConfidence)")
                            .padding(5)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .font(.title)
                )
                    .padding(.bottom)
            }
            .foregroundColor(.white)
            .padding()
            
            //button stack
            VStack{
                HStack(spacing: 30) {
                    Button(action: {
                        self.topPrediction = ""
                        self.secondPrediction = ""
                        self.topConfidence = ""
                        self.secondConfidence = ""
                        self.placeHolderIsShown = false
                        self.showImagePicker = true
                    }) {
                        Image(systemName: "photo.on.rectangle")
                        Text("Library")
                            .padding(.horizontal)
                    }
                    .padding()
                    .foregroundColor(.black)
                    .background(Color(UIColor.systemYellow))
                    .cornerRadius(25)
                    
                    
                    Button(action: {
                        self.topPrediction = self.defaults.string(forKey: "TopPrediction") ?? "No prediction available"
                        self.secondPrediction = self.defaults.string(forKey: "SecondPrediction") ?? "No prediction available"
                        self.topConfidence = self.defaults.string(forKey: "TopConfidence") ?? "No confidence available"
                        self.secondConfidence = self.defaults.string(forKey: "SecondConfidence") ?? "No confidence available"
                    }) {
                        Image(systemName: "questionmark.square.fill")
                        Text("Predict")
                            .padding(.horizontal)
                    }
                    .padding()
                    .foregroundColor(.black)
                    .background(Color(UIColor.systemYellow))
                    .cornerRadius(25)
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: self.$image)
            }
        }
        .background(Image("background"))
        .edgesIgnoringSafeArea(.all)
        .padding()
        
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
