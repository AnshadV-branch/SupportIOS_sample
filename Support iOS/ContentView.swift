//
//  ContentView.swift
//  Support iOS
//
//  Created by Anshad V on 19/03/23.
//
import SwiftUI
import BranchSDK

struct ContentView: View {
    @State private var showSafari: Bool = false
    public var shortUrl: String = ""
    
    var body: some View {
        
        HStack {
            Button(action: {
                generateDeepLink()
            }) {
                Text("Generate Deeplink")
                    .bold()
                    .font(.title3)
            }
            .padding(10.0)
            
            Button (action: {
                showSafari.toggle()
            }) {
                Text ("in app browser")
                    .bold ()
                    .font(.title3)
            }
            .padding (10.0)
            .onChange (of: showSafari) { newValue in
            if newValue {
                }
            }
            .fullScreenCover(isPresented: $showSafari, content: {
                SFSafariViewWrapper(url: URL(string: "https://tmn.app.link/gncscanb?codeValue=https%3A%2F%2Fglobal.alipay.com%2F281002040098ZTH76Gk2g30m9F1kYGrv4ZbQ")!)
            })
        }
        
        
        Text(shortUrl)
            .font(.largeTitle)
            .bold()
            .padding()
            .onTapGesture(count: 2) {
                let clipboard = UIPasteboard.general
                clipboard.setValue(shortUrl, forPasteboardType: UTType.plainText.identifier)
        }
    }
    
    func generateDeepLink() {
        
        let buo = BranchUniversalObject.init(canonicalIdentifier: "content/12345")
        buo.title = "My Content Title"
        buo.contentDescription = "My Content Description"
        buo.imageUrl = "https://lorempixel.com/400/400"
        buo.publiclyIndex = true
        buo.locallyIndex = true
        buo.contentMetadata.customMetadata["key1"] = "value1"
        
        let lp = BranchLinkProperties()
        lp.channel = "facebook"
        lp.feature = "sharing"
        lp.campaign = "content 123 launch"
        lp.stage = "new user"
        lp.tags = ["one", "two", "three"]

        lp.addControlParam("$desktop_url", withValue: "http://example.com/desktop")
        //lp.addControlParam("$ios_url", withValue: "http://example.com/ios")
        lp.addControlParam("$ipad_url", withValue: "http://example.com/ios")
        lp.addControlParam("$android_url", withValue: "http://example.com/android")
        lp.addControlParam("$match_duration", withValue: "2000")

        lp.addControlParam("custom_data", withValue: "yes")
        lp.addControlParam("look_at", withValue: "this")
        lp.addControlParam("nav_to", withValue: "over here")
        lp.addControlParam("random", withValue: UUID.init().uuidString)
        
        buo.getShortUrl(with: lp) { url, error in
                print(url ?? "")
         
            }
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
