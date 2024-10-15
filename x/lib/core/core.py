from abc import ABC, abstractmethod
from typing import Dict, List


class Element(ABC):
    def __init__(self, tag_name: str):
        self.tag_name = tag_name
        self.attributes: Dict[str, str] = {}
        self.children: List[Element] = []

    def set_attribute(self, name: str, value: str) -> None:
        self.attributes[name] = value

    def append_child(self, child: 'Element') -> None:
        self.children.append(child)

    @abstractmethod
    def render(self) -> str:
        pass


class HTMLElement(Element):
    def render(self) -> str:
        attributes_str = ' '.join(f'{name}="{value}"' for name, value in self.attributes.items())
        children_str = ''.join(child.render() for child in self.children)
        return f'<{self.tag_name} {attributes_str}>{children_str}</{self.tag_name}>'


class TextNode(Element):
    def __init__(self, text: str):
        super().__init__('')
        self.text = text

    def render(self) -> str:
        return self.text
