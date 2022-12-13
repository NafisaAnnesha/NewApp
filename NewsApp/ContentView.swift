//
//  ContentView.swift
//  NewsApp
//
//  Created by Nafisa Annesha on 12/9/22.
//
//
import SwiftUI
import UserNotifications
import UIKit



enum URLError: Error {
    case BadURL, BadData
}

struct ContentView: View {
    
    //   let helper = Helper()
    @State private var showingSheet = false
    @State private var showingSheet2 = false
    @State private var showAlert = false
    @State private var alert = false
    @State private var showDetailView = false
    @State private var isShowingInfoView = false
    //  @State var state = WebView.State.standby
    @State private var headlines: [Article] = []
    @State private var notFound = false
    
    @State private var urlString: String = "https://nasa.gov/"
    @State private var title: String = ""
    @State private var author: String = "unknown"
    @State private var description: String = ""
    @State private var imageUrl: String = ""
    @State private var datePublished: String = ""
    @State private var content: String = ""
    @State private var date: Date = Date()
    @EnvironmentObject var helper: Helper
    @State private var showingAlert = false
    @AppStorage("type") var type = "top-headlines"
    @AppStorage("category") var category = ""
    @AppStorage("keyword") var q = ""
    @AppStorage("sortby") var sortby = "relevency"
    @AppStorage("language") var language = "en"
    @AppStorage("sources") var source = ""
    //var title = "bbc-news"
    
    
    
    @State private var showProgress: Bool = false
    
    init() {
      let coloredAppearance = UINavigationBarAppearance()
      coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = UIColor(named: "barColor")
      coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
      coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      
      UINavigationBar.appearance().standardAppearance = coloredAppearance
      UINavigationBar.appearance().compactAppearance = coloredAppearance
      UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
      
      UINavigationBar.appearance().tintColor = .white
    }
    
    @FocusState var focus: Bool
    var body: some View {
        
        NavigationView{
 
            if showProgress == true {
                Spacer()
                ProgressView()
                Spacer()
            }
            
            else {  
                        VStack{
                            HStack{
                                if helper.news?.totalResults == 0 {
          
                                    Text("No relevent article found. Please try again with different keywords.")
                                        .font(.title)
                                        .foregroundColor(.red)
                                        .padding()
                                }else {
                                    List(helper.news?.articles ?? []){ article in
                                        VStack{
                                            HStack{
                                                Text(article.title ?? "")
                                                    .font(.headline)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                    .multilineTextAlignment(.leading)
                               
                                        Spacer()
                                        AsyncImage(
                                            url: URL(string: article.urlToImage ?? "not found"),
                                            content: { image in
                                                image.resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                 //   .frame(maxWidth: 300, maxHeight: 100)
                                            },
                                            placeholder: {
                                                ProgressView()
                                                    
                                            }
                                        )
                                        .aspectRatio(contentMode: .fit)
                                            }
                                            Button(action: {
                                                urlString = article.url ?? ""
                                                title = article.title ?? ""
                                                description = article.articleDescription ?? ""
                                                content = article.content ?? ""
                                                imageUrl = article.urlToImage ?? ""
                                                author = article.author ?? "unknown"
                                                datePublished = article.publishedAt ?? ""
                                                date = dateFromString(datePublished)
                                              
                                            }, label: {
                                                Text("")
                        
                                                    .foregroundColor(Color(red: 0.9, green: 0.768, blue: 0.406))
                                                    .padding()
                                            })
                                            .frame(width: 0, height: 0, alignment: .trailing)
                                            NavigationLink("", destination:  DetailView(content: $content, title: $title, imageUrl: $imageUrl, author: $author, datePublished: $date, urlString: $urlString, description: $description), isActive: $showDetailView)
                                               
                                        }
                     
                                }
                                   
                                    
                                }
                                
                         
                        }
                    }
                        
                    .toolbar {
                        
                        ToolbarItem(placement: .bottomBar) {
                                                Button(action: {
                            
                                                   
                                                    showProgress = true
                            
                                                    Task {
                                                        await loadSymbol()
                                                    }
                            
                                                    showProgress = false
                            
                            
                                                }, label: {
                                                    Text("Refresh")
                                                        .foregroundColor(Color("TextColor"))
                                                })
                                              
                        }
                        ToolbarItem(placement: .navigationBarLeading){
                            Button(action: {
                                isShowingInfoView.toggle()
                            }, label: {
                                Label("Info", systemImage: "questionmark.app.fill")
                                    .foregroundColor(Color.white)
                            })
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showingSheet2.toggle()
                            }, label: {
                                Label("Settings", systemImage: "gearshape.fill")
                                    .foregroundColor(Color.white)
                            })
                        }
                    }
                
                    .alert("The search query everthing is not supported category; It also requires keyword or source", isPresented: $showAlert) {
                               Button("OK", role: .cancel) {
                                   showAlert = false
                               }
                           }
                    .sheet(isPresented: $showingSheet2) {
                     
                        Button(action: {
                            showingSheet2.toggle()
                         //   print(type)
                            if(type == "everything"){
                               category = ""
                                    Task {
                                            DispatchQueue.main.async {
                                                    Thread.sleep(forTimeInterval: 0.01)
                                                    showAlert = true
                                            }
                                    }
                            }
                        }, label: {
                            Text("done")
                                .foregroundColor(Color.white)
                                .padding()
                        })
                            .background(Color("barColor"))
                            .cornerRadius(15)
                          //  .frame(width: 300, height: 30, alignment: .center)
                            .padding()
                        SettingsView(type: $type, category: $category, keyword: $q, language: $language, sortby: $sortby, source: $source)
                     
                    }
                    .sheet(isPresented: $isShowingInfoView) {
                     
                        Button(action: {
                            isShowingInfoView.toggle()
                                             }, label: {
                            Text("done")
                                                     .foregroundColor(Color.white)
                                .padding()
                        })
                            .background(Color("barColor"))
                            .cornerRadius(15)
                          //  .frame(width: 300, height: 30, alignment: .center)
                            .padding()
                        InfoView()
                     
                    }
                   
                    
                    
                    .navigationTitle("Today's Headline")
                    
                    .task {
                        
                        await loadSymbol()
                    }
                    
                
            }
            
            //                    Spacer()
            //
            //                    Button(action: {
            //
            //
            //                        showProgress = true
            //
            //                        Task {
            //                            await loadSymbol()
            //                        }
            //
            //                        showProgress = false
            //
            //
            //                    }, label: {
            //                        Text("Refresh")
            //
            //                            .foregroundColor(Color(red: 0.9, green: 0.768, blue: 0.406))
            //                            .padding()
            //                    })
            
            
            // }
            //.navigationTitle("dwdwq")
            //     .navigationTitle("Today's Headline")
        }
       
       
        
    }
    
    func loadSymbol() async {
        do{
            
            try await helper.fetch(symbol: type, category: category, sortby: sortby, language: language, q: q, source: source)
            
            
        } catch{
            print("---> task error: \(error)")
        }
    }
    func dateFromString(_ string: String) -> Date {
          let dateFormatter = DateFormatter()
          dateFormatter.locale = .current
          dateFormatter.dateFormat = "yyyy-MM-dd"
          return dateFormatter.date(from: string) ?? Date()
      }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
            .environmentObject(Helper())
    }
}
//import SwiftUI
//
//enum URLError: Error {
//    case BadURL, BadData
//}
//
//struct ContentView: View {
//    @State private var urlString: String = "https://nasa.gov/"
//    @State private var showingSheet = false
//    var body: some View {
//        NavigationView{
//
//        }
//        Button (action: {
//            urlString = "http://www.bbc.co.uk/news/world-asia-china-63926374"
//                        showingSheet.toggle()
//                   },label: {
//
//                       Label("" , systemImage: "gearshape.fill")
//                           .foregroundColor(Color(red: 0.998, green: 0.813, blue: 0.433))
//                   }).padding(27.0)
//                     .sheet(isPresented: $showingSheet) {
//
//                         WebView(urlString: $urlString)
//                     }
//        TabView {
//
//            WebView()
//                .tabItem {
//                    Label(TabType.webview.title(), image: TabType.webview.image())
//                }
//                .tag(0)
//
//        }
//        .preferredColorScheme(.dark)
//  }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
