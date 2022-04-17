//
//  LessonDetailView.swift
//  IPSLessonViewer
//
//  Created by Azhar Islam on 14/04/2022.
//

import SwiftUI
import AVKit

struct LessonDetailView: View {
    
    var lesson: Lesson
    @State var player: AVPlayer?
    @StateObject var viewModel = LessonsViewModel(service: LessonsService())
    
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var downloadModel = DownloadVideoService()
    
    var body: some View {
        
        NavigationView {
            VStack.init(alignment: .leading, spacing: 10) {
                VideoPlayer(player: player).frame(height: UIScreen.main.bounds.height / 3.5)
                    .onAppear() {
                        player = AVPlayer(url: URL(string: lesson.videoURL ?? "")!)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                Text(lesson.name ?? "")
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 10))
                Text(lesson.lessonDescription ?? "")
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 10))
                NavigationLink(destination: {
                    LessonDetailView(lesson: returnNextIndex())
                }, label: {
                    HStack(alignment: .center, spacing: 0) {
                        Text("Next Lesson")
                            .foregroundColor(.blue)
                            .padding(.all, 0)
                        Image("indicator")
                            .padding(.leading, 0)
                    }
                    .position(x: 300, y: 50)
                    
                })
                Spacer()
            } // VStack - Lesson Detail View
            
            .background(Color(Colors.darkGrey).edgesIgnoringSafeArea(.all))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack(alignment: .center, spacing: 3) {
                        Image("leftArrow")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.leading, 0)
                            .foregroundColor(.blue)
                        Text("Lessons")
                            .foregroundColor(.blue)
                            .padding(.all, 0)
                    } // HStack - Back Button
                }),
                trailing: Button(action: {
                    downloadModel.startDownload(urlString: lesson.videoURL ?? "")
                }) {
                    HStack(alignment: .center, spacing: 3) {
                        Image("downloadVideo")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.leading, 0)
                            .foregroundColor(.blue)
                        Text("Download")
                            .foregroundColor(.blue)
                            .padding(.all, 5)
                    } // HStack - Download Button
                })
            .alert(isPresented: $downloadModel.showAlert, content: {
                Alert(title: Text("Complete"),
                      message: Text(downloadModel.alertMessage),
                      dismissButton:
                        .destructive(Text("OK")
                            .foregroundColor(.blue),
                                     action: {}))
            })
            .overlay(
                ZStack {
                    if downloadModel.showDownloadProgress {
                        DownloadProgressView(progress: $downloadModel.downloadProgress)
                            .environmentObject(downloadModel)
                    }
                } // ZStack - Download Progress HUD
            )
        } // NavigationView
        .navigationBarHidden(true)
    }
    
    func returnNextIndex() -> Lesson {
        guard let currentIndex = viewModel.lessons.firstIndex(of: lesson) else {
            return Lesson(id: 0, name: "", lessonDescription: "", thumbnail: "", videoURL: "")
        }
        var nextIndex = currentIndex+1
        nextIndex = viewModel.lessons.indices.contains(nextIndex) ? nextIndex : 0
        return viewModel.lessons[nextIndex]
    }
}


struct LessonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LessonDetailView(lesson: .dummyData)
    }
}

struct LessonVideoPlayer: UIViewControllerRepresentable {
    
    @Binding var player : AVPlayer
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<LessonVideoPlayer>) -> some AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = true
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
