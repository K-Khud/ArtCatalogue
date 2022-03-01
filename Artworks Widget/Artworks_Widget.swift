//
//  Artworks_Widget.swift
//  Artworks Widget
//
//  Created by Ekaterina Khudzhamkulova on 30.1.2022.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), suffixes: ["Placeholder"])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), suffixes: ["Snapshot"])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let nextUpdate = Calendar.current.date(byAdding: .second, value: 1, to: Date())
        let timeLine = Timeline(entries: [SimpleEntry(date: Date(), suffixes: WidgetBridget.shared.topThree)],
                                policy: .after(nextUpdate!))
        completion(timeLine)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    var suffixes: [String]

}

struct Artworks_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
            ZStack {
                Colors.blueGreen
                HStack {
                    Spacer(minLength: 0)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Artworks")
                            .widgetURL(LinkNames.artworks!)
                            .foregroundColor(Colors.freesia)
                            .background(.ultraThinMaterial)
                            .cornerRadius(6)
                        Text("Artists")
                            .widgetURL(LinkNames.artists!)
                            .foregroundColor(Colors.coral)
                            .background(.ultraThinMaterial)
                            .cornerRadius(6)
                        Text("Suffixes")
                            .widgetURL(LinkNames.suffixes!)
                            .foregroundColor(Colors.fuchsia)
                            .background(.ultraThinMaterial)
                            .cornerRadius(6)
                    }
                    .padding(.vertical)
                    Spacer(minLength: 0)
                    VStack {
                        ForEach(entry.suffixes, id: \.self) { suffix in
                            Text(suffix)
                                .foregroundColor(Colors.blueGreen)
                        }
                    }
                     Spacer(minLength: 0)
                }
            }
    }
}

@main
struct Artworks_Widget: Widget {
    let kind: String = "Artworks_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            Artworks_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Artworks Widget")
        .description("Dispalys suffixes analysis. Provides navigation to artworks app. ")
    }
}

struct Artworks_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Artworks_WidgetEntryView(entry: SimpleEntry(date: Date(), suffixes: [""]))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            Artworks_WidgetEntryView(entry: SimpleEntry(date: Date(), suffixes: [""]))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            Artworks_WidgetEntryView(entry: SimpleEntry(date: Date(), suffixes: [""]))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            Artworks_WidgetEntryView(entry: SimpleEntry(date: Date(), suffixes: [""]))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            Artworks_WidgetEntryView(entry: SimpleEntry(date: Date(), suffixes: [""]))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
