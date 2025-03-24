import SwiftUI

struct DesignCode {
    struct AestheticButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            AestheticButton(configuration: configuration)
        }
        
        struct AestheticButton: View {
            let configuration: Configuration
            @State private var isHovered: Bool = false
            
            var body: some View {
                configuration.label
                    .frame(width: 150, height: 18)
                    .font(.headline.bold())
                    .foregroundColor(Color(red: 123/255, green: 114/255, blue: 105/255))
                    .padding(8)
                    .background(isHovered ? Color.clear : Color(red: 198/255, green: 208/255, blue: 199/255))
                    .cornerRadius(13)
                    .overlay(
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .stroke(isHovered ? Color(red: 198/255, green: 208/255, blue: 199/255) : Color.clear, lineWidth: 1)
                    )
                    .scaleEffect(1.0)
                    .onHover { hovering in
                        isHovered = hovering
                    }
            }
        }
    }
    
    struct MonthSelectorButtonStyle: ButtonStyle {
        let staticColor = Color(red: 246/255, green: 170/255, blue: 121/255)
        let hoverColor = Color(red: 246/255, green: 248/255, blue: 243/255)
        let borderColor = Color(red: 246/255, green: 170/255, blue: 121/255)
        var width: CGFloat = 250
        var height: CGFloat = 50
        
        func makeBody(configuration: Configuration) -> some View {
            MonthSelectorButton(configuration: configuration, staticColor: staticColor, hoverColor: hoverColor, borderColor: borderColor, width: width, height: height)
        }
        
        struct MonthSelectorButton: View {
            let configuration: Configuration
            let staticColor: Color
            let hoverColor: Color
            let borderColor: Color
            let width: CGFloat
            let height: CGFloat
            @State private var isHovered: Bool = false
            
            var body: some View {
                configuration.label
                    .font(.headline.bold())
                    .foregroundColor(Color(red: 123/255, green: 114/255, blue: 105/255))
                    .padding(8)
                    .frame(width: width, height: height)
                    .background(isHovered ? hoverColor : staticColor)
                    .cornerRadius(13)
                    .overlay(
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .stroke(isHovered ? borderColor : Color.clear, lineWidth: 1)
                    )
                    .onHover { hovering in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isHovered = hovering
                        }
                    }
            }
        }
    }
    
    static let backgroundColor: Color = Color(red: 246/255, green: 248/255, blue: 243/255)
    static let textColor: Color = Color(red: 123/255, green: 114/255, blue: 105/255)
}
