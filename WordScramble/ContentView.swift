//
//  ContentView.swift
//  WordScramble
//
//  Created by Garret Poole on 2/25/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
    }
    
    func loadFile() {
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            //here means file was found inside installed app bundle on user device and can be loaded
            if let fileContents = try? String(contentsOf: fileURL) {
                //here means loaded file into string fileContents
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
