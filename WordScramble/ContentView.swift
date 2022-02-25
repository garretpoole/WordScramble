//
//  ContentView.swift
//  WordScramble
//
//  Created by Garret Poole on 2/25/22.
//

import SwiftUI

struct ContentView: View {
    let people = ["Fin", "Leia", "Luke", "Rey"]
    var body: some View {
//        List(people, id: \.self){
//            Text("\($0)")
        List{
            Text("Static Row 1")
            ForEach(people, id: \.self){
                Text("\($0)")
            }
            Text("Static Row 2")
            Text("Static Row 3")
            
        }
        .listStyle(.grouped)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
