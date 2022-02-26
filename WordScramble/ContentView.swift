//
//  ContentView.swift
//  WordScramble
//
//  Created by Garret Poole on 2/25/22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Enter you word", text: $newWord)
                        .autocapitalization(.none)
                        .onSubmit(addNewWord)
                }
                Section{
                    ForEach(usedWords, id: \.self){ word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onAppear(perform: startGame)
            
            
            .alert(errorTitle, isPresented: $showingError){
                Button("OK", role: .cancel){}
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from the bundle")
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 3 else {
            wordError(title: "Word is too small", message: "Must be 3 letters or more")
            return
        }
        
        guard !(answer==rootWord) else {
            wordError(title: "Cannot use root word", message: "Really...")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word already used", message: "Be original")
            return
        }
        
        guard isPossible(word: answer) else{
            wordError(title: "Word is not possible", message: "Cannot spell '\(answer)' from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else{
            wordError(title: "Word not recognized", message: "Try a dictionary")
            return
        }
        
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool{
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool{
        var tempWord = rootWord
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
