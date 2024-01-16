//
//  ContentView.swift
//  screencapture-clueso
//
//  Created by shashvat singh on 16/01/24.
//

import SwiftUI

struct ContentView: View {
    @State var image = NSImage();
    
    var body: some View {
        VStack {
            Button("Screen Shot"){
                if screenshotWindowAndSuccess() {
                    image = getImageFromPasteboard();
                }
            }
            .padding()
            Image(nsImage: image)
                .padding()
        }
        .padding()
    }
    

    func screenshotWindowAndSuccess() -> Bool {
        let task = Process();
        task.launchPath = "/usr/sbin/screencapture";
        task.arguments = ["-vIu"];
        task.launch();
        task.waitUntilExit();
        let status = task.terminationStatus;
        return status == 0;
    }
    
    func getImageFromPasteboard() -> NSImage {
        let pasteboard = NSPasteboard.general;
        guard pasteboard.canReadItem(withDataConformingToTypes:
                                        NSImage.imageTypes) else { return NSImage(); }
        guard let image = NSImage(pasteboard: pasteboard) else { return
            NSImage() };
        return image;
    }
}

#Preview {
    ContentView()
}
