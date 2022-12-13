//
//  DetailView.swift
//  NewsApp
//
//  Created by Nafisa Annesha on 12/11/22.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var content: String
    @Binding var title: String
    @Binding var imageUrl: String
    @Binding var author: String
    @Binding var  datePublished: Date
    @Binding var  urlString: String
    @Binding var description: String
    @State private var count = 1.0
    @State private var isShowing = false
    @State private var exit = false
    var body: some View {
        
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [ Color("Color-2"),  Color("Color-2"), Color("Color-3")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea([.all])
            ScrollView {
                VStack{
                    
                    
                    Text(title)
                    
                        .font(.title)
                        .foregroundColor(Color("TextColor"))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                    
                    HStack{
                        Text("Author:")
                            .foregroundColor(Color("TextColor"))
                        Text(author)
                            .font(.headline)
                            .foregroundColor(Color("TextColor"))
                        .fontWeight(.light)}
                    Text(datePublished, formatter: itemFormatter)
                        .font(.subheadline)
                        .foregroundColor(Color("TextColor"))
                        .fontWeight(.thin)
                    Text(description)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("TextColor"))
                        .padding()
                    
                    HStack{
                        Button("+") {
                            count += 0.1
                        }
                        .foregroundColor(Color("TextColor"))
                        .padding()
                        
                        Button("-") {
                            count -= 0.1
                        }
                        .foregroundColor(Color("TextColor"))
                        .padding()
                    }
                    AsyncImage(
                        url: URL(string: imageUrl),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 500, maxHeight: 300)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    .aspectRatio(contentMode: .fit)
                    //  Text(description)
                    //  font(.caption2)
                    
                    Text(content)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(Color("TextColor"))
                    NavigationLink("Read full article") {
                        WebView(urlString: $urlString)
                        
                    }.foregroundColor(Color.white)
                    Spacer()
                    
                
                    Button("Show in browser") {
                        
                        isShowing = true
                    }
                    
                    .foregroundColor(Color.white)
                    
                    .actionSheet(isPresented: $isShowing) {
                        ActionSheet(
                            title: Text("Opening browser will exit the app, do you wish to continue?"),
                            buttons: [
                                .destructive(Text("Yes"),
                                             action: {
                                                 if let url = URL(string: urlString) {
                                                     UIApplication.shared.open(url)
                                                 }
                                                 //    exit = true
                                                 
                                             }
                                            ),
                                .cancel()
                            ]
                        ) }
                    
                }
                .scaleEffect(count)
                .animation(.linear(duration: 1), value: count)
                
                
                
                
            }
        }
    }
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter
    }()
    
}
