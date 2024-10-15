use std::collections::HashMap;

trait Element {
    fn set_attribute(&mut self, name: &str, value: &str);
    fn append_child(&mut self, child: Box<dyn Element>);
    fn render(&self) -> String;
}

struct HTMLElement {
    tag_name: String,
    attributes: HashMap<String, String>,
    children: Vec<Box<dyn Element>>,
}

impl HTMLElement {
    fn new(tag_name: &str) -> Self {
        HTMLElement {
            tag_name: tag_name.to_string(),
            attributes: HashMap::new(),
            children: Vec::new(),
        }
    }
}

impl Element for HTMLElement {
    fn set_attribute(&mut self, name: &str, value: &str) {
        self.attributes.insert(name.to_string(), value.to_string());
    }

    fn append_child(&mut self, child: Box<dyn Element>) {
        self.children.push(child);
    }

    fn render(&self) -> String {
        let attributes_str = self
            .attributes
            .iter()
            .map(|(name, value)| format!("{}=\"{}\"", name, value))
            .collect::<Vec<String>>()
            .join(" ");

        let children_str = self
            .children
            .iter()
            .map(|child| child.render())
            .collect::<Vec<String>>()
            .join("");

        format!(
            "<{} {}>{}</{}>",
            self.tag_name, attributes_str, children_str, self.tag_name
        )
    }
}

struct TextNode {
    text: String,
}

impl TextNode {
    fn new(text: &str) -> Self {
        TextNode {
            text: text.to_string(),
        }
    }
}

impl Element for TextNode {
    fn set_attribute(&mut self, _name: &str, _value: &str) {
        // Text nodes do not have attributes, so this method does nothing.
    }

    fn append_child(&mut self, _child: Box<dyn Element>) {
        // Text nodes cannot have child elements, so this method does nothing.
    }

    fn render(&self) -> String {
        self.text.clone()
    }
}

fn main() {
    let mut div = HTMLElement::new("div");
    div.set_attribute("class", "container");

    let mut heading = HTMLElement::new("h1");
    heading.append_child(Box::new(TextNode::new("Welcome to NMOX!")));

    div.append_child(Box::new(heading));

    println!("{}", div.render());
}
