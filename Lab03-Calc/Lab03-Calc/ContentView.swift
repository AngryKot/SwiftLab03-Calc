//
//  ContentView.swift
//  Lab03-Calc-Fedulova
//
//  Created by Polina Fedulova on 18.10.2023.
//


import SwiftUI

struct ContentView: View {

    @State var a: String = "0" // первое число
    @State var b: String = "0" // второе число
    @State var fn: String = "" // тип операции (+, -, *, /)

    var body: some View {
        ZStack {
            Color("background")
            VStack(spacing: 1) {
                Spacer()
                Text(fn.count == 0 ? a : b)
                    .font(.system(size: 90))
                    .frame(width: UIScreen.main.bounds.width, alignment: .trailing)

                HStack(spacing: 1) {
                    Button(action: {
                        self.a = "0"
                        self.b = "0"
                        self.fn = ""
                    }) {
                        ZStack {
                            Color("btn_special")
                            Text("AC")
                        }
                    }
                    Button(action: {
                        if self.fn != "" {
                            self.b = String(-(Float(self.b) ?? 0))
                        } else {
                            self.a = String(-(Float(self.a) ?? 0))
                        }
                    }) {
                        ZStack {
                            Color("btn_special")
                            Image(systemName: "plus.forwardslash.minus")
                        }
                    }
                    Button(action: {
                        if self.fn != "" {
                            self.b = String((Float(self.b) ?? 0) / 100)
                        } else {
                            self.a = String((Float(self.a) ?? 0) / 100)
                        }
                        }) {
                        ZStack {
                            Color("btn_special")
                            Text("%")
                        }
                    }
                    Button(action: {
                        self.fn = "/"
                    }) {
                        ZStack {
                            Color("btn_action")
                            Image(systemName: "divide")
                        }
                    }
                }.frame(height: UIScreen.main.bounds.width / 4)

                HStack(spacing: 1) {
                    Button(action: {
                        self.appendDigit("7")
                    }) {
                        ZStack {
                            Color("btn_digit")
                            Text("7")
                        }
                    }
                    Button(action: {
                        self.appendDigit("8")
                    }) {
                        ZStack {
                            Color("btn_digit")
                            Text("8")
                        }
                    }
                    Button(action: {
                        self.appendDigit("9")
                    }) {
                        ZStack {
                            Color("btn_digit")
                            Text("9")
                        }
                    }
                    Button(action: {
                        self.fn = "*"
                    }) {
                        ZStack {
                            Color("btn_action")
                            Image(systemName: "multiply")
                        }
                    }
                }.frame(height: UIScreen.main.bounds.width / 4)

                HStack(spacing: 1) {
                    Button(action: {
                        self.appendDigit("4")
                    }) {
                        ZStack {
                            Color("btn_digit")
                            Text("4")
                        }
                    }
                    Button(action: {
                        self.appendDigit("5")
                    }) {
                        ZStack {
                            Color("btn_digit")
                            Text("5")
                        }
                    }
                    Button(action: {
                        self.appendDigit("6")
                    }) {
                        ZStack {
                            Color("btn_digit")
                            Text("6")
                        }
                    }
                    Button(action: {
                        self.fn = "-"
                    }) {
                        ZStack {
                            Color("btn_action")
                            Text("–")
                        }
                    }
                }.frame(height: UIScreen.main.bounds.width / 4)

                HStack(spacing: 1) {
                    Button(action: {
                        self.appendDigit("1")
                    }) {
                        ZStack {
                            Color("btn_digit")
                            Text("1")
                        }
                    }
                    Button(action: {
                        self.appendDigit("2")
                    }) {
                        ZStack {
                            Color("btn_digit")
                            Text("2")
                        }
                    }
                    Button(action: {
                        self.appendDigit("3")
                    }) {
                        ZStack {
                            Color("btn_digit")
                            Text("3")
                        }
                    }
                    Button(action: {
                        self.fn = "+"
                    }) {
                        ZStack {
                            Color("btn_action")
                            Text("+")
                        }
                    }
                }.frame(height: UIScreen.main.bounds.width / 4)

                HStack(spacing: 1) {
                    Button(action: {
                        self.appendDigit("0")
                    }) {
                        ZStack {
                            Color("btn_digit")
                            Text("0")
                        }
                    }.frame(width: UIScreen.main.bounds.width / 2 - 0.5)
                    Button(action: {
                        if self.fn.isEmpty {
                            self.appendDecimalPoint(&self.a)
                        } else {
                            self.appendDecimalPoint(&self.b)
                        }
                    }) {
                        ZStack {
                            Color("btn_digit")
                            Text(".")
                        }
                    }
                    Button(action: {
                        self.calculateResult()
                    }) {
                        ZStack {
                            Color("btn_action")
                            Text("=")
                        }
                    }
                }.frame(height: UIScreen.main.bounds.width / 4)
            }
        }
        .foregroundColor(.white)
        .font(.system(size: 25))
    }

    // Метод для добавления цифр в числа a и b, учитывая ограничения
    private func appendDigit(_ digit: String) {
        if self.fn.count == 0 {
            if self.a == "0" || self.a.count < 9 {
                self.a = self.a == "0" ? digit : self.a + digit
            }
        } else {
            if self.b == "0" || self.b.count < 9 {
                self.b = self.b == "0" ? digit : self.b + digit
            }
        }
    }

    // Метод для добавления десятичной точки в числа a и b, учитывая ограничения
    private func appendDecimalPoint(_ value: inout String) {
        if !value.contains(".") {
            value += "."
        }
    }

    // Метод для вычисления результата
    private func calculateResult() {
        let x: Float = Float(self.a) ?? 0
        let y: Float = Float(self.b) ?? 0

        if self.fn == "/" {
            if y != 0 {
                self.a = String(x / y)
            } else {
                self.a = "Error"
            }
        }
        if self.fn == "*" {
            self.a = String(x * y)
        }
        if self.fn == "+" {
            self.a = String(x + y)
        }
        if self.fn == "-" {
            self.a = String(x - y)
        }

        self.b = "0"
        self.fn = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


