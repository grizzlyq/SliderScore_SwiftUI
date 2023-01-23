//
//  SliderView.swift
//  SliderScore_SwiftUI
//
//  Created by Дмитрий on 21.01.2023.
//

import SwiftUI

struct SliderView: UIViewRepresentable {
    
    @Binding var sliderValue: Double
    
    let color: UIColor
    let alpha: Int
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        
        slider.minimumValue = 1
        slider.maximumValue = 100
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.changeValue),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.thumbTintColor = color.withAlphaComponent(CGFloat(alpha) / 100)
        uiView.value = Float(sliderValue)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $sliderValue)
    }
    
}

extension SliderView {
    class Coordinator: NSObject {
        @Binding var sliderValue: Double
        
        init(value: Binding<Double>) {
            self._sliderValue = value
        }
        
        @objc func changeValue(_ sender: UISlider) {
            sliderValue = Double(sender.value)
        }
    }
    
    
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(sliderValue: .constant(50), color: .blue, alpha: 100)
    }
}
