<?php

/**
 * USAGE:
// $div = new HTMLElement('div');
// $div->setAttribute('class', 'container');
// $heading = new HTMLElement('h1');
// $heading->appendChild(new TextNode('Welcome to NMOX!'));
// $div->appendChild($heading);
// echo $div->render();
 */

namespace NMOX\HTMLBuilder;

abstract class Element
{
    protected $tagName;
    protected $attributes = [];
    protected $children = [];

    public function __construct(string $tagName)
    {
        $this->tagName = $tagName;
    }

    public function setAttribute(string $name, string $value): void
    {
        $this->attributes[$name] = $value;
    }

    public function appendChild(Element $child): void
    {
        $this->children[] = $child;
    }

    abstract public function render(): string;
}

class HTMLElement extends Element
{
    public function render(): string
    {
        $attributes = implode(' ', array_map(
            fn($name, $value) => "$name=\"$value\"",
            array_keys($this->attributes),
            array_values($this->attributes)
        ));

        $children = implode('', array_map(
            fn($child) => $child->render(),
            $this->children
        ));

        return "<{$this->tagName} $attributes>$children</{$this->tagName}>";
    }
}

class TextNode extends Element
{
    private $text;

    public function __construct(string $text)
    {
        parent::__construct('');
        $this->text = $text;
    }

    public function render(): string
    {
        return $this->text;
    }
}
