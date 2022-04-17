//
//  NextButton.swift
//  IPSLessonViewer
//
//  Created by Azhar Islam on 16/04/2022.
//

import SwiftUI

struct NextButtonView: View {
    
    let action: () -> Void
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button(action: {}) {
            HStack(alignment: .center, spacing: 0) {
                Text("Next Lesson")
                    .foregroundColor(.blue)
                    .padding(.all, 0)
                Image("indicator")
                    .padding(.leading, 0)
            }
        }
    }
}

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButtonView(action: {})
    }
}
