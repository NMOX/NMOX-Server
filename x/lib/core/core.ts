abstract class Element {
    protected tagName: string;
    protected attributes: { [key: string]: string };
    protected children: Element[];

    constructor(tagName: string) {
        this.tagName = tagName;
        this.attributes = {};
        this.children = [];
    }

    setAttribute(name: string, value: string): void {
        this.attributes[name] = value;
    }

    appendChild(child: Element): void {
        this.children.push(child);
    }

    abstract render(): string;
}

class HTMLElement extends Element {
    constructor(tagName: string) {
        super(tagName);
    }

    render(): string {
        const attributesStr = Object.entries(this.attributes)
            .map(([name, value]) => `${name}="${value}"`)
            .join(' ');

        const childrenStr = this.children.map(child => child.render()).join('');

        return `<${this.tagName} ${attributesStr}>${childrenStr}</${this.tagName}>`;
    }
}

class TextNode extends Element {
    private text: string;

    constructor(text: string) {
        super('');
        this.text = text;
    }

    render(): string {
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
