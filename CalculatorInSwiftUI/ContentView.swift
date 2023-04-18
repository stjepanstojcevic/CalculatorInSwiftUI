//
//  ContentView.swift
//  CalculatorInSwiftUI
//
//  Created by Stjepan Stojčević on 18.04.2023..
//

import SwiftUI

enum CalcButton : String
{
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case add = "+"
    case divide = "/"
    case mulitiple = "*"
    case equal = "="
    case subtract = "-"
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
        
    var buttonColor:Color
    {
        switch self {
        case .add,.subtract,.mulitiple,.divide,.equal:
            return .orange
        case .negative,.clear,.percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiple, divide, nonee
    
}

struct ContentView: View {
    @State var value = "0"
    @State var currentOperation: Operation? = Operation.nonee
    @State var runningNumber = 0
    
    let buttons : [[CalcButton]] = [
        [.clear,.negative,.percent,.divide],
        [.seven,.eight,.nine,.mulitiple],
        [.four,.five,.six,.subtract],
        [.one,.two,.three,.add],
        [.zero,.decimal,.equal]]
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size:50))
                        .foregroundColor(.white)
                    
                }.padding()
                
                ForEach(buttons,id: \.self) { row in
                    HStack(spacing:12){
                        ForEach(row,id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size:30))
                                    .frame(width:self.buttonWidth(item: item),height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item))
                            })
                        }
                    }.padding(.bottom,3)
                }
            }
        }
    }
    
    func didTap(button:CalcButton)
    {
        switch button{
        case .add,.subtract,.mulitiple,.divide,.equal:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber+=Int(self.value) ?? 0
            }
            else if button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber+=Int(self.value) ?? 0
            }
            else if button == .mulitiple{
                self.currentOperation = .multiple
                self.runningNumber+=Int(self.value) ?? 0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber+=Int(self.value) ?? 0
            }
            else if button == .equal{
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation{
                case .add : self.value="\(runningValue+currentValue)"
                case .subtract : self.value="\(runningValue-currentValue)"
                case .multiple : self.value="\(runningValue*currentValue)"
                case .divide :
                    if currentValue != 0 {
                        self.value="\(runningValue/currentValue)"
                    }
                    else{
                        self.value="Undefined"
                    }
                case .nonee:
                    break
                default:
                    break
                }
            }
            if button != .equal{
                self.value = "0"
            }
        
        case .clear:
            self.value = "0"
        case .decimal,.negative,.percent:
            break
        default:
            let number = button.rawValue
            if self.value=="0"{
                value=number
            }
            else{
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item:CalcButton)->CGFloat{
        if item == .zero
        {
            return ((UIScreen.main.bounds.width-(4*12))/4)*2
        }
        return (UIScreen.main.bounds.width-(5*12))/4
    }
    func buttonHeight()->CGFloat{
        return (UIScreen.main.bounds.width-(5*12))/4
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
