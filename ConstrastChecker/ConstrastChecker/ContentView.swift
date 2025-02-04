
import SwiftUI
import UIKit


struct ContentView: View {
    
    
    // @StateObject is used to create and maintain our CheckColors through view updates
    @StateObject private var checker = CheckColors()
    
    
    // Test info button
    
    func openInfo() {
        print("Open app info")
    }
    
    func fixColors() {
        print("aaa")
    }
    
    var body: some View {
        
        VStack (spacing: 24) {
            
//            Spacer()

            VStack (spacing: 16) {
                
                HStack {
                    Text("Aa")
                    Spacer()
                    Text("< & % ! >")
                        .fontWeight(.regular)
                    Spacer()
                    Image(systemName: "seal.fill")
                    Spacer()
                    Image(systemName: "eye.fill")
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                
                HStack {
                    Image(systemName: "moon.fill")
                    Spacer()
                    Image(systemName: "square.fill")
                    Spacer()
                    Image(systemName: "circle.fill")
                    Spacer()
                    Image(systemName: "triangle.fill")
                    Spacer()
                    Text("Some lazy dog.")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Text("A user squints, with soaring eyes, as the contrast ratio cries. It'll all be fine, just fix your f*cking color guide.")
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                
            }
            .foregroundColor(checker.foregroundColor)
            
            // Foreground rectangle. Fill property calls var checker, which calls CheckColors.
            
            Rectangle()
                .fill(checker.foregroundColor)
                .frame(height: 100)
                .cornerRadius(24)

            // Info card
            
            VStack (alignment: .leading, spacing: 16) {
                
                // Contrast ratio
                
                HStack {
                    Text("Contrast ratio")
                    Spacer()
                    Text(String(format: "%.2f : 1", checker.calculateContrastRatio().ratio))
                }
                
                // Normal text
                
                HStack {
                    Text("Normal text")
                    Spacer()
                    Text(checker.calculateContrastRatio().normalText.display)
                        .frame(width: 40)
                        .padding(4)
                        .background() {
                            if checker.calculateContrastRatio().normalText == .fail {
                                Color.red
                            }
                            else {
                                Color.green
                            }
                        }
                        .foregroundColor(.white)
                        .cornerRadius(4)
                }
                
                // Large text
                
                HStack {
                    Text("Large text")
                    Spacer()
                    Text(checker.calculateContrastRatio().largeText.display)
                        .frame(width: 40)
                        .padding(4)
                        .background() {
                            if checker.calculateContrastRatio().largeText == .fail {
                                Color.red
                            }
                            else {
                                Color.green
                            }
                        }
                        
                        .foregroundColor(.white)
                        .cornerRadius(4)
                }
                
                // Graphics
                
                HStack {
                    Text("Graphics")
                    Spacer()
                    Text(checker.calculateContrastRatio().graphics.display)
                        .frame(width: 40)
                        .padding(4)
                        .background() {
                            if checker.calculateContrastRatio().graphics == .fail {
                                Color.red
                            }
                            else {
                                Color.green
                            }
                           
                        }
                        .foregroundColor(.white)
                        .cornerRadius(4)
                }
                
            
            //    .background(checker.calculateContrastRatio().graphics == .fail ? Color.red : Color.green)
                
                
                Divider()
                
                // Foreground color picker.
                
                ColorPicker ("Foreground color", selection: $checker.foregroundColor)
                    
                
                ColorPicker ("Background color", selection: $checker.backgroundColor)
                
                
            }
            .padding(24)
            .background(.white)
            .cornerRadius(24)
            .fontWeight(.medium)
            
            // Button group
            
            HStack {
                
                // Button that swaps foreground and background colors
                
                Button (action: checker.swapColors,
                    label: {
                        Spacer()
                        Image(systemName: "rectangle.2.swap")
                        Text("Swap")
                    Spacer()
                    }
                )
                .foregroundColor(.black)
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .controlSize(.large)
                .cornerRadius(100)

                // Button that opens the app info sheet
             
                Button (action: openInfo,
                    label: {
                        Image(systemName: "info.circle")
                    }
                )
                .foregroundColor(.black)
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .controlSize(.large)
                .cornerRadius(100)
                
            }
            
            
            
        }
        .padding(32)
        .frame(maxHeight: .infinity)
        .background(checker.backgroundColor)
    }
}

#Preview {
    ContentView()
}
