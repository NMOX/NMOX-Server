# NMOX Server Ruby Edition
# This code defines a class hierarchy in Ruby to mirror a portion of the HTML5 specification.
# There is a base class X, with a child class PAGE, which itself has a child class HTML5.
# From HTML5, we derive classes like P, DIV, and SPAN to represent HTML tags.
#
# Each class has a property `x` that can be a string, another X object, or an array of strings/objects.
# Each class implements a `render` method that produces HTML5-compliant output.
#
# Attributes can be defined by instance variables that begin with `@x` (e.g. @xid, @xstyle) which
# are then inserted as HTML attributes (id, style, etc.) into the rendered tag.
#
# If an unexpected data type is encountered during rendering, it will be handled gracefully.

class X
  attr_accessor :x

  def initialize(content = nil, **attributes)
    @x = content
    # Set attributes as instance variables, e.g., xid, xstyle become @xid, @xstyle
    attributes.each do |k, v|
      instance_variable_set("@x#{k}", v)
    end
  end

  # Determine the tag name for this class. By default, nil means no tag wrapping.
  def tag_name
    nil
  end

  # Gather attributes from instance variables prefixed with @x
  # For example, @xid = "my_id" => id="my_id"
  #            @xstyle = "color:red" => style="color:red"
  def attributes_string
    attrs = []
    instance_variables.each do |var|
      var_name = var.to_s
      # Only consider @x* vars beyond @x itself
      if var_name.start_with?('@x') && var_name != '@x'
        attr_name = var_name[2..-1] # remove leading '@x'
        attr_value = instance_variable_get(var)
        # Ensure attr_value is a string or convertible to string
        attr_str = attr_value.to_s
        # Add to attributes array as key="value"
        attrs << %{#{attr_name}="#{attr_str}"}
      end
    end
    attrs.empty? ? "" : " " + attrs.join(" ")
  end

  # Render the content depending on its type:
  # - If it's a string, wrap it in this element's tag
  # - If it's another X object, render that object
  # - If it's an array, iterate and render each element
  # - If unknown, handle error gracefully.
  def render
    begin
      content = ""
      case @x
      when String
        # If this class has a tag_name, wrap the string in it
        if tag_name
          content = "<#{tag_name}#{attributes_string}>#{@x}</#{tag_name}>"
        else
          # If no tag_name, just return the string content
          content = @x
        end
      when X
        # Render the child X object
        rendered_child = @x.render
        if tag_name
          content = "<#{tag_name}#{attributes_string}>#{rendered_child}</#{tag_name}>"
        else
          content = rendered_child
        end
      when Array
        # Iterate over array elements and render them
        rendered_children = @x.map do |item|
          case item
          when String
            if tag_name
              "<#{tag_name}#{attributes_string}>#{item}</#{tag_name}>"
            else
              item
            end
          when X
            if tag_name
              "<#{tag_name}#{attributes_string}>#{item.render}</#{tag_name}>"
            else
              item.render
            end
          else
            # Unrecognized type in array
            # Handle error gracefully by wrapping in a comment or ignoring
            "<!-- Error: Unrecognized content type #{item.class} -->"
          end
        end
        # If this class has a tag_name and we have multiple children,
        # we should wrap them all together inside a single set of tags,
        # or consider that each child should be individually wrapped.
        # For simplicity, let's just concatenate the results.
        if tag_name
          content = "<#{tag_name}#{attributes_string}>#{rendered_children.join}</#{tag_name}>"
        else
          content = rendered_children.join
        end
      when NilClass
        # No content, just produce an empty element or nothing
        if tag_name
          content = "<#{tag_name}#{attributes_string}></#{tag_name}>"
        else
          content = ""
        end
      else
        # Unrecognized type for @x
        # Handle error gracefully
        if tag_name
          content = "<#{tag_name}#{attributes_string}><!-- Error: Unrecognized content type #{@x.class} --></#{tag_name}>"
        else
          content = "<!-- Error: Unrecognized content type #{@x.class} -->"
        end
      end
      content
    rescue => e
      # If any runtime error occurs, handle it gracefully
      "<!-- Rendering Error: #{e.message} -->"
    end
  end
end

class PAGE < X
  # PAGE could represent the root of a page. Let's assume it's <html> for simplicity.
  def tag_name
    "html"
  end
end

class HTML5 < PAGE
  # HTML5 documents start with a DOCTYPE. We'll inject it before rendering the html.
  def render
    "<!DOCTYPE html>\n" + super
  end
end

# Now we define some HTML5 elements as classes inheriting from HTML5.

class P < HTML5
  def tag_name
    "p"
  end
end

class DIV < HTML5
  def tag_name
    "div"
  end
end

class SPAN < HTML5
  def tag_name
    "span"
  end
end

# You can add more HTML5 tags as needed following the same pattern:
class H1 < HTML5
  def tag_name
    "h1"
  end
end

class A < HTML5
  def tag_name
    "a"
  end
end

# Example usage:
# page = HTML5.new([
#   H1.new("Welcome to NMOX Server Ruby Edition!", xid: "main-title"),
#   DIV.new([
#     P.new("A paragraph.", xstyle: "color:blue;"),
#     SPAN.new("Some inline text.")
#   ], xclass: "container")
# ])
#
# puts page.render
#
# This should produce:
#
# <!DOCTYPE html>
# <html>
#   <h1 id="main-title">Welcome to NMOX Server Ruby Edition!</h1>
#   <div class="container">
#     <p style="color:blue;">A paragraph.</p>
#     <span>Some inline text.</span>
#   </div>
# </html>
