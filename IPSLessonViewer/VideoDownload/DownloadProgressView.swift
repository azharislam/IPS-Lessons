//
//  DownloadProgressView.swift
//  IPSLessonViewer
//
//  Created by Azhar Islam on 14/04/2022.
//

import SwiftUI

struct DownloadProgressView: View {
    
    @Binding var progress: CGFloat
    @EnvironmentObject var downloadService: DownloadVideoService
    
    var body: some View {
        
        ZStack {
            Color.primary
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                    ProgressShape(progress: progress)
                        .fill(Color.blue)
                        .rotationEffect(.init(degrees: -90))
                    
                } // ZStack - Download Progress HUD
                .frame(width: 70, height: 70)
                
                // Cancel Button
                Button(action: {
                    downloadService.cancelTask()
                }, label: {
                    Text("Cancel")
                        .fontWeight(.semibold)
                })
                .padding(.top)
            } // VStack - Everything
            .padding(.vertical, 20)
            .padding(.horizontal, 50)
            .background(Color.white)
            .cornerRadius(8)
        } // ZStack - Background
    }
}

struct DownloadProgressView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadProgressView(progress: .constant(0.5))
    }
}

struct ProgressShape: Shape {
    
    var progress: CGFloat
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: 35,
                startAngle: .zero,
                endAngle: .init(degrees: Double(progress * 360)),
                clockwise: false)
        }
    }
}
