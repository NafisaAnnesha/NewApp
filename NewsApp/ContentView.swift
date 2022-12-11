//
//  ContentView.swift
//  NewsApp
//
//  Created by Nafisa Annesha on 12/9/22.
//
//
import SwiftUI




enum URLError: Error {
    case BadURL, BadData
}

struct ContentView: View {

 //   let helper = Helper()
    @State private var showingSheet = false
  //  @State var state = WebView.State.standby
    @State private var headlines: [Article] = []
    @State private var notFound = false

    @State private var urlString: String = "https://nasa.gov/"
 //   @State var state = WebViewRep.State.standby
//    @State private var urlString: String = article.url
    @EnvironmentObject var helper: Helper
    @AppStorage("name") var name = "top-headlines"
    @AppStorage("source") var source = "bbc-news"
    var title = "bbc-news"



    @State private var showProgress: Bool = false



    @FocusState var focus: Bool
    var body: some View {
        NavigationView {
        ZStack{
           Color(red: 0.118, green: 0.118, blue: 0.122)
                .ignoresSafeArea()
        VStack{

            Text("Bored? How about you...")
                .foregroundColor(.white)
            Spacer()
            if showProgress == true {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                List(helper.news?.articles ?? []){ article in  // <-- here
                    VStack{
                      Text(article.title)
                        Spacer()
                        AsyncImage(
                    url: URL(string: article.urlToImage ?? ""),
                     content: { image in
                        image.resizable()
                          .aspectRatio(contentMode: .fit)
                               .frame(maxWidth: 300, maxHeight: 100)
                                      },
                                    placeholder: {
                            ProgressView()
                                      }
                                  )


                        .aspectRatio(contentMode: .fit)
                        Text(article.content)
                        

                           }
                    Button (action: {
                        urlString = article.url
                                    showingSheet.toggle()
                               },label: {
               
                                   Label("" , systemImage: "gearshape.fill")
                                       .foregroundColor(Color(red: 0.998, green: 0.813, blue: 0.433))
                               }).padding(27.0)
                                 .sheet(isPresented: $showingSheet) {
               
                                     WebView(urlString: $urlString)
                                 }
//




                  }
                  .task {
                      print(urlString)
                      do{
                          try await helper.fetch(symbol: name, source: source)

                      } catch{
                          print("---> task error: \(error)")
                      }
                  }


            Spacer()
            Button(action: {
                Task {

                    showProgress = true

                 //   await loadSymbol(symbol: name)

                    showProgress = false
                }
            }, label: {
                Text("Ask the Oracle")

                    .foregroundColor(Color(red: 0.9, green: 0.768, blue: 0.406))
                    .padding()
            })

            }
        }
        }.navigationTitle("sdd")
        }
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
