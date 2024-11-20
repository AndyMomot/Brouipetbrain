//
//  PreloaderView.swift
//  Libarorent
//
//  Created by Andrii Momot on 06.10.2024.
//

import SwiftUI
import Combine

struct PreloaderView: View {
    
    @State private var timer: Timer?
    @State private var progress: Double = 0.0
    
    let onDidLoad = PassthroughSubject<Void, Never>()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack() {
            Colors.greenCustom.swiftUIColor
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                Asset.preloaderBg.swiftUIImage
                    .resizable()
                    .scaledToFit()
                
                VStack(spacing: 10) {
                    CircularProgressBar(
                        progress: progress,
                        trackColor: .clear,
                        progressColor: .white,
                        lineWidth: 10,
                        lineCap: .round
                    )
                    .frame(width: 80)
                    
                    Text("Loading")
                        .foregroundStyle(.white)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 25))
                }
                
                Spacer()
            }
        }
        .onAppear {
            startTimer()
        }
    }
}

private extension PreloaderView {
    func startTimer() {
        stopTimer()
        
        timer = .scheduledTimer(withTimeInterval: 0.05,
                                repeats: true, block: { timer in
            let value = Double.random(in: 0.03...0.05)
            updateProgress(value: value)
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateProgress(value: Double) {
        DispatchQueue.main.async {
            if progress + value > 1 {
                progress = 1
                stopTimer()
                onDidLoad.send()
            } else {
                progress = progress + value
            }
            
            
        }
    }
}

#Preview {
    PreloaderView()
}
