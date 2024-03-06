//
//  ContentView.swift
//  screencapture-clueso
//
//  Created by shashvat singh on 16/01/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State var videoURL: URL? = nil;
    @State var task: Process? = nil;
    @State var isRecording: Bool = false;
    var body: some View {
        VStack {
            Button("Screen Record"){
                if(!isRecording){
                    screenshotWindowAndSuccess();
                }
            }
            .padding()
            if isRecording {
                Button("Stop Recording"){
                    stopRecording();
                }
            }
            if (!isRecording && videoURL != nil) {
                        VideoPlayer(player: AVPlayer(url: videoURL!))
                    .frame(width: 600, height: 300)
                    } else {
                        Text("Video not found")
                    }
        }
        .padding()
    }
    

    func screenshotWindowAndSuccess() -> Void {
        task = Process();
        task!.launchPath = "/usr/sbin/screencapture";
        
        let fileManager = FileManager.default
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return;
        }
        
        let video = documentsURL.appendingPathComponent("screencapture.mov");
        task!.arguments = ["-vuk", video.absoluteString];
        videoURL = video.absoluteURL;
        print(videoURL!);
        task!.launch();
        print("\(task!.processIdentifier)");
        isRecording = true;
    }
    
    func stopRecording() -> Void {
        let stopTask = Process()
            stopTask.launchPath = "/usr/bin/kill"
        stopTask.arguments = ["-INT", "\(task!.processIdentifier)"]
            stopTask.launch()
        isRecording = false
    }
}

#Preview {
    ContentView()
}
