//
//  BottomSheetView.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 2 // rectangle
    static let indicatorWidth: CGFloat = 30
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.3
}
struct BottomSheetView<Content: View>: View {
    @Binding var isOpen: Bool
    @Binding var lightBg : Bool
   

    let bgColor : Color
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    @GestureState private var translation: CGFloat = 0
  
    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight + 80
    }
    
    
    private var indicator: some View {
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color.gray)
            .frame(
                width: Constants.indicatorWidth,
                height: Constants.indicatorHeight
            ).onTapGesture {
                self.isOpen.toggle()
            }
    }
    
    
    init(isOpen: Binding<Bool> , bgColor : Color , lightBg: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
        self._lightBg = lightBg
        self.bgColor = bgColor

    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator
                    .padding()
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
          .background(bgColor)
            
            .cornerRadius(Constants.radius)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * Constants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }
}


struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView(isOpen: .constant(false), bgColor: .black, lightBg: .constant(false), maxHeight: 650) {
            Rectangle().fill(Color.red)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
