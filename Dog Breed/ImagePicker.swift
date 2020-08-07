//
//  ImagePicker.swift
//  Dog Breed
//
//  Created by Shabbir Saifee on 8/1/20.
//  Copyright © 2020 Shabbir Saifee. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: Image?
//    @Binding var isShown: Bool
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) ->  UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator(self)
    }
    
    class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let userImage = info[.originalImage] as? UIImage {
                guard let convertedImage = CIImage(image: userImage) else { fatalError("Cannot convert to CIImage") }
                
                DetectImage().detect(image: convertedImage)
                parent.image = Image(uiImage: userImage)
//                parent.isShown = false
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
}
