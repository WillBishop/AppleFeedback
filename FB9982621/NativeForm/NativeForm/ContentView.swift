//
//  ContentView.swift
//  formtest
//
//  Created by Will Bishop on 14/4/2022.
//

import SwiftUI
import UIKit

struct ContentView: View {
	
	@State var alertShowing = false
	var body: some View {
		Button {
			self.alertShowing = true
		} label: {
			Text("Show Alert")
		}

	}
	
}

struct AlertWrapper: UIViewRepresentable {
	



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
