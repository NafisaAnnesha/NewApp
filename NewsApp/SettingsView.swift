//
//  SettingsView.swift
//  Bored

  //Created by Nafisa Annesha on 12/4/22.


import SwiftUI
import UserNotifications
import UIKit
struct SettingsView: View {
    
    @State private var showKeyboard = true;
    @State private var show = true;
    @State private var types = ["everything", "top-headlines"]
    @State private var sources = [ " Tap to select a Source", "bbc-news", "CNN", "Espn", "abc-news"]
//    @State private var selectedType = ""
    @State private var categories = ["Tap to select", "business", "entertainment", "general", "health", "science", "sports", "technology"]
    @State private var sort = ["popularity", "relevancy", "publishedAt"]
    @State private var languages = ["ar","de", "en", "es", "fr", "he", "it", "nl","no", "pt", "ru", "sv", "ud", "zh"]
    @Binding var type: String
    @Binding var category: String
    @Binding var keyword: String
    @Binding var language: String
    @Binding var sortby: String
    @Binding var source: String
    @State private var alert = false
    @State private var selectedSource = false
    @State private var selectedCategory = false
    @FocusState private var isFocused: Bool
  
    var body: some View {
        VStack{
        Form{
           
            Section("Type"){
                Picker("", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.wheel)
                
            }
            Section("Search by Source"){
                HStack{
                    VStack{
                        if selectedSource {
                            TextField("Type Source Name", text: $source)
                                .textFieldStyle(.roundedBorder)
                                
                                .focused($isFocused)
                            }
                        if isFocused == false  {
                    Picker("", selection: $source) {
                        ForEach(sources, id: \.self) {
                           
                                Text($0)
                            
                        }
                    }
                    
                    .pickerStyle(.menu)
                       
                        }
                            
                        
                    }
                    .disabled(selectedSource == false)
                    Toggle("", isOn: $selectedSource.animation())
                }
            }.disabled(selectedCategory == true)
        
            Section("Category"){
               
                HStack{
                   
                    if selectedCategory {
                    Picker("", selection: $category) {
                        ForEach(categories, id: \.self) {
                            
                            Text($0).animation(
                                .easeInOut(duration: 2)
                                    .delay(1),
                                value: 1.0
                            )
                        }
                    }
                    .disabled(selectedCategory == false)
                        .pickerStyle(.menu)}
                    Toggle("", isOn: $selectedCategory.animation())
                }
            }.disabled(selectedSource == true)
            
            Section("SortBy"){
                Picker("", selection: $sortby) {
                    ForEach(sort, id: \.self) {
                        Text($0)
                            
                    }
                }
               
                .pickerStyle(.wheel)
                .aspectRatio(contentMode:.fit)
             
            }
            
            Section("Select Language"){
                Picker("", selection: $language) {
                    ForEach(languages, id: \.self) {
                        Text($0)
                          

                    }
                }
                
                
            
                .pickerStyle(.menu)
                .background(.bar)

            }
            Section("Search by Keywords"){
                TextField("Type Keywords", text: $keyword)

            }
        
           // Section("Keywords"){
      
        }
        .onTapGesture {
            if(selectedSource){
                category = ""
            }
            if(selectedCategory){
                source = ""
            }
           
          //  if(!showKeyboard){
                isFocused = false
           // navigate = true
        }
            
            Button (action: {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {(status,_)in
                    if status {
                        let content = UNMutableNotificationContent()
                        content.title = "Notification"
                        content.body = "Check what is happening around the world today!"
                        content.sound = UNNotificationSound.default
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:5, repeats: false)
                        
                        let request = UNNotificationRequest(identifier:UUID().uuidString, content: content, trigger: trigger)
                        UNUserNotificationCenter.current().add(request)
                        return
                    }
                    self.alert.toggle()
                }
                
            }){
                Text("Notification")
                
            }
            
        }
}
}
//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(type: $type)
//    }
//}
