class Element {
    constructor(tagName) {
        this.tagName = tagName;
        this.attributes = {};
        this.children = [];
    }

    setAttribute(name, value) {
        this.attributes[name] = value;
    }

    appendChild(child) {
        this.children.push(child);
    }

    render() {
        throw new Error('render() method must be implemented by subclasses');
    }
}

class HTMLElement extends Element {
    constructor(tagName) {
        super(tagName);
    }

    render() {
        const attributesStr = Object.entries(this.attributes)
            .map(([name, value]) => `${name}="${value}"`)
            .join(' ');

        const childrenStr = this.children.map(child => child.render()).join('');

        return `<${this.tagName} ${attributesStr}>${childrenStr}</${this.tagName}>`;
    }
}

class TextNode extends Element {
    constructor(text) {
        super('');
        this.text = text;
    }

    render() {
        return this.text;
    }
}

// Usage example
const div = new HTMLElement('div');
div.setAttribute('class', 'container');

const heading = new HTMLElement('h1');
heading.appendChild(new TextNode('Welcome to NMOX!'));

div.appendChild(heading);

console.log(div.render());
