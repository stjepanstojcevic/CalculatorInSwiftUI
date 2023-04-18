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
    case mulitiply = "*"
    case equal = "="
    case subtract = "-"
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
        
    var buttonColor:Color
    {
        switch self {
        case .add,.subtract,.mulitiply,.divide,.equal:
            return .orange
        case .negative,.clear,.percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, percent,decimal, nonee
    
}

struct ContentView: View {
    @State var value = "0.0"
    @State var lastValue = "0.0"
    @State var currentOperation: Operation? = Operation.nonee
    @State var runningNumber = 0.0
    
    let buttons : [[CalcButton]] = [
        [.clear,.negative,.percent,.divide],
        [.seven,.eight,.nine,.mulitiply],
        [.four,.five,.six,.subtract],
        [.one,.two,.three,.add],
        [.zero,.decimal,.equal]]
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors:
                            [Color.black,Color.blue,Color.white]),
                           startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                HStack{
                    Text(lastValue)
                        .bold()
                        .font(.system(size:20))
                        .foregroundColor(.white)
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size:50))
                        .foregroundColor(.red)
                    
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
        case .add,.subtract,.mulitiply,.divide,.equal,.decimal:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber=Double(self.value) ?? 0.0
            }
            else if button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber=Double(self.value) ?? 0.0
            }
            else if button == .mulitiply{
                self.currentOperation = .multiply
                self.runningNumber=Double(self.value) ?? 0.0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber=Double(self.value) ?? 0.0
            }
            if button == .decimal{
                self.currentOperation = .decimal
                self.runningNumber=Double(self.value) ?? 0.0
            }
            else if button == .equal{
                let runningValue = Double(self.runningNumber)
                let currentValue = Double(self.value) ?? 0.0
                self.lastValue="\(runningValue)"
                switch self.currentOperation{
                case .add : self.value="\(runningValue+currentValue)"
                    self.lastValue="\(runningValue)"
                case .subtract : self.value="\(runningValue-currentValue)"
                    self.lastValue="\(runningValue)"
                case .multiply : self.value="\(runningValue*currentValue)"
                    self.lastValue="\(runningValue)"
                case .decimal : self.value="\(Int(runningValue)).\(Int(currentValue))"
                    self.lastValue="\(runningValue)"
                case .divide :
                    if currentValue != 0 {
                        self.value="\(runningValue/currentValue)"
                        self.lastValue="\(runningValue)"
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
                self.value = "0.0"
            }
        case .percent:
            self.value = "\(Double(self.value)!/100.0)"
            self.lastValue="\(Double(self.runningNumber))"
        case .clear:
            self.value = "0.0"
            self.lastValue="\(Double(self.runningNumber))"
        case .negative:
            self.value = "\(Double(self.value)!*(-1))"
            self.lastValue="\(Double(self.runningNumber))"
        
        default:
            let number = button.rawValue
            if self.value=="0.0"{
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
