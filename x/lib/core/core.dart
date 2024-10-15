abstract class Element {
  String tagName;
  Map<String, String> attributes = {};
  List<Element> children = [];

  Element(this.tagName);

  void setAttribute(String name, String value) {
    attributes[name] = value;
  }

  void appendChild(Element child) {
    children.add(child);
  }

  String render();
}

class HTMLElement extends Element {
  HTMLElement(String tagName) : super(tagName);

  @override
  String render() {
    String attributesStr = attributes.entries
        .map((entry) => '${entry.key}="${entry.value}"')
        .join(' ');

    String childrenStr = children.map((child) => child.render()).join('');

    return '<$tagName $attributesStr>$childrenStr</$tagName>';
  }
}

class TextNode extends Element {
  String text;

  TextNode(this.text) : super('');

  @override
  String render() {
    return text;
  }
}

void main() {
  HTMLElement div = HTMLElement('div');
  div.setAttribute('class', 'container');

  HTMLElement heading = HTMLElement('h1');
  heading.appendChild(TextNode('Welcome to NMOX!'));

  div.appendChild(heading);

  print(div.render());
}
