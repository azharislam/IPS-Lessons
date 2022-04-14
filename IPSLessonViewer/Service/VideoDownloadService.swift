//
//  VideoDownloadService.swift
//  IPSLessonViewer
//
//  Created by Azhar Islam on 14/04/2022.
//

import SwiftUI

class DownloadVideoService: NSObject, ObservableObject, URLSessionDownloadDelegate, UIDocumentInteractionControllerDelegate {
    
    @Published var downloadUrl: URL!
    @Published var downloadTaskSession: URLSessionDownloadTask!
    @Published var downloadProgress: CGFloat = 0
    @Published var showDownloadProgress = false
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    func startDownload(urlString: String) {
        
        // Check if valid URL
        guard let validUrl = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Check if download already exists, if yes, open downloaded video. If not, download video.
        let directoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        if FileManager.default.fileExists(atPath: directoryPath.appendingPathComponent(validUrl.lastPathComponent).path) {
            print("File already exists here")
            self.showDownloadComplete(message: "This lesson has already been downloaded")
        } else {
            print("No file found, proceed download")
            downloadProgress = 0
            withAnimation{showDownloadProgress = true}
            
            // Download Task
            let session = URLSession(
                configuration: .default,
                delegate: self,
                delegateQueue: nil)
            downloadTaskSession = session.downloadTask(with: validUrl)
            downloadTaskSession.resume()
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        // Check if valid URL
        guard let url = downloadTask.originalRequest?.url else {
            print("Something went wrong, please debug")
            return
        }
        
        // Save in app document directory and show in document controller
        let directoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let destinationUrl = directoryPath.appendingPathComponent(url.lastPathComponent)
        
        try? FileManager.default.removeItem(at: destinationUrl)
        
        do {
            
            
            try FileManager.default.copyItem(at: location, to: destinationUrl)
            
            print("Saved item success")
            
            DispatchQueue.main.async {
                withAnimation{self.showDownloadProgress = false}
                self.showDownloadComplete(message: "Saved to files")
            }
        }
        catch {
            print("Error trying to save into directory")
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let progress = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
            self.downloadProgress = progress
        }
    }
    
    func showDownloadComplete(message: String) {
        alertMessage = message
        showAlert.toggle()
    }
    
    // Cancel download
    func cancelTask() {
        if let task = downloadTaskSession,
           task.state == .running {
            downloadTaskSession.cancel()
            withAnimation{self.showDownloadProgress = false}
        }
    }
}
