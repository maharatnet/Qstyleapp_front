import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';



class HtmlToRichTextWidget extends StatelessWidget {
  final String? htmlString;

  const HtmlToRichTextWidget({Key? key, this.htmlString = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final document = //html_parser.
    parse(htmlString);
    // final inlineSpans = _parseNode(document.body!);

    return Container(
      child:HtmlWidget(document.body!.outerHtml,

        textStyle: TextStyle(fontSize: 11, color: Colors.grey),),

    );
  }
  // Html(data: document.body!.outerHtml,),
  //----------------//
  // child: Html(data:document.body!.outerHtml),
  // RichText(
  //   text: TextSpan(
  //       children: inlineSpans,
  //       // style: const TextStyle(color: Colors.black)
  //   ),
  // ),
  List<InlineSpan> _parseNode(dom.Node node) {
    final inlineSpans = <InlineSpan>[];

    if (node.nodeType == dom.Node.TEXT_NODE) {
      final text = node.text;
      inlineSpans.add(TextSpan(text: text));
    } else if (node.nodeType == dom.Node.ELEMENT_NODE) {
      final element = node as dom.Element;

      switch (element.localName) {
        case "b":
        case 'strong':
          return _parseElements(
              element, const TextStyle(fontWeight: FontWeight.bold));
        case "i":
        case 'em':
          return _parseElements(
              element, const TextStyle(fontStyle: FontStyle.italic));
        case "u":
          return _parseElements(
              element, const TextStyle(decoration: TextDecoration.underline));
        case "sub":
          inlineSpans.add(WidgetSpan(
            alignment: PlaceholderAlignment.bottom,
            child: SizedBox(
              height: 10,
              child: Text(
                element.text,
                style: const TextStyle(
                  fontSize: 12,
                  // color: Colors.blue,
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
            ),
          ));
          break;
        case "sup":
          inlineSpans.add(WidgetSpan(
            alignment: PlaceholderAlignment.top,
            child: SizedBox(
              height: 10,
              child: Text(
                element.text,
                style: const TextStyle(
                  fontSize: 12,
                  // color: Colors.blue,
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
            ),
          ));
          break;
        case "p":
          return _parseElements(element, const TextStyle());
        case "span":
        // print(element.className);
          return _parseElements(element, const TextStyle(color: Colors.red));

        case "a":
          final href = element.attributes['href'] ?? '';
          return _parseElements(
              element,
              const TextStyle(
                  decoration: TextDecoration.underline, color: Colors.blue),
              href);
        case 'br':
          inlineSpans.add(const TextSpan(text: "\n"));
          break;
        default:
          return _parseElements(element, const TextStyle());
      }
    }

    return inlineSpans;
  }

  List<InlineSpan> _parseElements(dom.Element element, TextStyle style,
      [String? href]) {
    final spans = <InlineSpan>[];

    for (final node in element.nodes) {
      final childTextSpans = _parseNode(node);

      for (final childTextSpan in childTextSpans) {
        var launch = TapGestureRecognizer()
          ..onTap = () => launchUrl(Uri.tryParse(href ?? "")!);
        if (childTextSpan is TextSpan) {
          spans.add(
            TextSpan(
              text: childTextSpan.text,
              style: style.merge(childTextSpan.style),
              recognizer: href != null ? launch : null,
            ),
          );
        } else {
          spans.add(childTextSpan);
          print(childTextSpan.toString());
        }
      }
    }
    return spans;
  }
}