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
    
    func test(){
        let input = """
a
b
c
"""
        let letters = input.components(separatedBy: "\n")
        let letter = letters.randomElement()
        //removes white space and new line
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let word = "swift"
        let checker = UITextChecker()
        //.utf16 is a character encoding to allow for Objective C to understand Swift strings
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        //checks if mispelledRange comes back empty
        let allGood = misspelledRange.location == NSNotFound
    }
}e

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
