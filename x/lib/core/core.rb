module NMOX
    module HTMLBuilder
      class Element
        attr_reader :tag_name, :attributes, :children
  
        def initialize(tag_name)
          @tag_name = tag_name
          @attributes = {}
          @children = []
        end
  
        def set_attribute(name, value)
          @attributes[name] = value
        end
  
        def append_child(child)
          @children << child
        end
  
        def render
          raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
        end
      end
  
      class HTMLElement < Element
        def render
          attributes_str = @attributes.map { |name, value| "#{name}=\"#{value}\"" }.join(' ')
          children_str = @children.map(&:render).join('')
  
          "<#{@tag_name} #{attributes_str}>#{children_str}</#{@tag_name}>"
        end
      end
  
      class TextNode < Element
        attr_reader :text
  
        def initialize(text)
          super('')
          @text = text
        end
  
        def render
          @text
        end
      end
    end
  end
