let Summer = ["🌞", "🍉", "⛱️", "🏄‍♂️", "🏊‍♀️", "🍦", "🌺", "🕶️", "🦩"]
let Winter = ["❄️", "☃️", "⛷️", "🌨️", "🎿", "🏂", "🔥", "🧣", "🧤", "⛄"]
let Space =  ["🚀", "👽", "🛰️", "🌠", "🛸", "🌍", "🌒", "🪐"]
import SwiftUI

struct ContentView: View {
    @State var cardCount = 20
    @State var emojiTheme = Winter
    var body: some View {
        VStack{
            Text("Memorize!").bold().font(.largeTitle).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            ScrollView{
                cards
            }
            }
            HStack{
                VStack{
                    spaceTheme
                }
                Spacer()
                summerTheme
                Spacer()
                winterTheme
            }.font(.largeTitle).imageScale(.large)
//            HStack{
//                CardAdder
//                Spacer()
//                CardRemover
//            }.font(.largeTitle).imageScale(.large)
    }
    var cards: some View {
        var displayedEmojis = emojiTheme.shuffled() + emojiTheme.shuffled()
        return LazyVGrid(columns: [GridItem(.adaptive(minimum:60))], content: {
                ForEach(0..<cardCount, id: \.self){ index in cardView(cardEmoji: displayedEmojis[index]).aspectRatio(2/3 , contentMode: .fit)}
            })
    }
//    func AdjustCardNum (by adjust : Int, Symbol: String) -> some View {
//        Button(action: {
//            cardCount += adjust
//        }, label: {
//            Image(systemName: Symbol)
//        }).disabled(cardCount + adjust < 1 || cardCount + adjust > emojiTheme.count * 2)
//    }
//    var CardAdder: some View{
//        AdjustCardNum(by: 1, Symbol: "rectangle.fill.badge.plus")
//    }
//    var CardRemover: some View{
//        AdjustCardNum(by: -1, Symbol: "rectangle.fill.badge.minus")
//    }
    func themeChoose(symbol: String, theme: [String]) -> some View{
        Button(action: {
            emojiTheme = theme
            if cardCount > emojiTheme.count {
                cardCount = emojiTheme.count*2
            }
        }, label: {
            VStack{
                Image(systemName: symbol)
                if theme == Summer{
                    Text("summer").font(.system(size: 20))
                }
                else if theme == Winter{
                    Text("winter").font(.system(size: 20))
                }
                else {
                    Text("space").font(.system(size: 20))
                }
            }
        }).disabled(theme == emojiTheme)
    }
    var spaceTheme: some View{
        themeChoose(symbol: "moon.stars.fill", theme: Space)
    }
    var winterTheme: some View{
        themeChoose(symbol: "thermometer.snowflake", theme: Winter)
    }
    var summerTheme: some View{
        themeChoose(symbol: "thermometer.sun.fill", theme: Summer)
    }


    }



struct cardView: View {
    let cardEmoji: String
    @State var isFaceUp = false
    var body: some View{
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.stroke(style: StrokeStyle(lineWidth: 4))
                Text(cardEmoji)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill(.blue).opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }.font(.largeTitle)
    }
}
#Preview {
    ContentView()
}
