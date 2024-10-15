using System;
using System.Collections.Generic;
using System.Text;

abstract class Element
{
    protected string TagName;
    protected Dictionary<string, string> Attributes;
    protected List<Element> Children;

    protected Element(string tagName)
    {
        TagName = tagName;
        Attributes = new Dictionary<string, string>();
        Children = new List<Element>();
    }

    public void SetAttribute(string name, string value)
    {
        Attributes[name] = value;
    }

    public void AppendChild(Element child)
    {
        Children.Add(child);
    }

    public abstract string Render();
}

class HTMLElement : Element
{
    public HTMLElement(string tagName) : base(tagName) { }

    public override string Render()
    {
        var attributesStr = new StringBuilder();
        foreach (var attribute in Attributes)
        {
            attributesStr.Append($"{attribute.Key}=\"{attribute.Value}\" ");
        }

        var childrenStr = new StringBuilder();
        foreach (var child in Children)
        {
            childrenStr.Append(child.Render());
        }

        return $"<{TagName} {attributesStr.ToString().Trim()}>{childrenStr.ToString()}</{TagName}>";
    }
}

class TextNode : Element
{
    private string Text;

    public TextNode(string text) : base("")
    {
        Text = text;
    }

    public override string Render()
    {
        return Text;
    }
}

class Program
{
    static void Main()
    {
        var div = new HTMLElement("div");
        div.SetAttribute("class", "container");

        var heading = new HTMLElement("h1");
        heading.AppendChild(new TextNode("Welcome to NMOX!"));

        div.AppendChild(heading);

        Console.WriteLine(div.Render());
    }
}
