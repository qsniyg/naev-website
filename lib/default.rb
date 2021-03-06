# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::Tagging
include Nanoc::Helpers::XMLSitemap
include Nanoc::Helpers::ChildParent
include Nanoc::Helpers::Blogging

require 'nanoc/filters/javascript_concatenator'
require 'image_size'

def image_with_size(item, alt='', class_code='', html_code='')
   begin 
      if item.class == Nanoc::CompilationItemView and not item.attributes[:content_filename].nil?
         img = ImageSize.new(IO.read(item.attributes[:content_filename]))
         "<img src='#{item.path}' height='#{img.height}' width='#{img.width}' alt=\"#{alt}\" class='img-fluid #{class_code}' #{html_code}/>"
      else
         img = ImageSize.new(IO.read("output/#{item.path}"))
         "<img src='#{item.path}' height='#{img.height}' width='#{img.width}' alt=\"#{alt}\" class='img-fluid #{class_code}' #{html_code}/>"
      end
   rescue
      "<img src='#{item.path}' alt=\"#{alt}\" class='img-fluid #{class_code}' #{html_code}/>"
   end
end

class Integer
  def ordinalize
    if (11..13).include?(self % 100)
      "#{self}th"
    else
      case self % 10
        when 1; "#{self}st"
        when 2; "#{self}nd"
        when 3; "#{self}rd"
        else    "#{self}th"
      end
    end
  end
end
