//
//  DetectImage.swift
//  Dog Breed
//
//  Created by Shabbir Saifee on 8/6/20.
//  Copyright © 2020 Shabbir Saifee. All rights reserved.
//

import SwiftUI
import CoreML
import Vision
import UIKit

class DetectImage {
    let defaults = UserDefaults.standard
    var saveTopPrediction = ""
    var saveSecondPrediction = ""
    var saveTopConfidence = ""
    var saveSecondConfidence = ""
    
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: All_AKC_Breeds_Reworked_1500().model) else {
            fatalError("Cannot import model")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            let classifications = request.results as! [VNClassificationObservation]
            let predicationIdentifiers = classifications.prefix(3)
            let predictedBreeds = predicationIdentifiers.map { classification in
                return classification.identifier
            }
            let predictionConfidence = predicationIdentifiers.map { classification in
                return String(format: "   %.0f %@", classification.confidence * 100, "%")
            }
            
            let firstPrediction = predictedBreeds[0]
            self.saveTopPrediction = firstPrediction
            
            let secondPrediction = predictedBreeds[1]
            self.saveSecondPrediction = secondPrediction
            
            let firstConfidence = predictionConfidence[0]
            self.saveTopConfidence = firstConfidence
            
            let secondConfidence = predictionConfidence[1]
            self.saveSecondConfidence = secondConfidence
            
            self.defaults.set(firstPrediction, forKey: "TopPrediction")
            self.defaults.set(secondPrediction, forKey: "SecondPrediction")
            self.defaults.set(firstConfidence, forKey: "TopConfidence")
            self.defaults.set(secondConfidence, forKey: "SecondConfidence")
        }
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    }
    
    struct ImageCapture: View {
        @Binding var image: Image?
        
        var body: some View {
            ImagePicker(image: $image)
        }
    }
}
