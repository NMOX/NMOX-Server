import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

abstract class Element {
    protected String tagName;
    protected Map<String, String> attributes;
    protected List<Element> children;

    public Element(String tagName) {
        this.tagName = tagName;
        this.attributes = new HashMap<>();
        this.children = new ArrayList<>();
    }

    public void setAttribute(String name, String value) {
        attributes.put(name, value);
    }

    public void appendChild(Element child) {
        children.add(child);
    }

    public abstract String render();
}

class HTMLElement extends Element {
    public HTMLElement(String tagName) {
        super(tagName);
    }

    @Override
    public String render() {
        StringBuilder attributesStr = new StringBuilder();
        for (Map.Entry<String, String> entry : attributes.entrySet()) {
            attributesStr.append(entry.getKey()).append("=\"").append(entry.getValue()).append("\" ");
        }

        StringBuilder childrenStr = new StringBuilder();
        for (Element child : children) {
            childrenStr.append(child.render());
        }

        return String.format("<%s %s>%s</%s>", tagName, attributesStr.toString().trim(), childrenStr.toString(), tagName);
    }
}

class TextNode extends Element {
    private String text;

    public TextNode(String text) {
        super("");
        this.text = text;
    }

    @Override
    public String render() {
        return text;
    }
}

public class Main {
    public static void main(String[] args) {
        HTMLElement div = new HTMLElement("div");
        div.setAttribute("class", "container");

        HTMLElement heading = new HTMLElement("h1");
        heading.appendChild(new TextNode("Welcome to NMOX!"));

        div.appendChild(heading);

        System.out.println(div.render());
    }
}
