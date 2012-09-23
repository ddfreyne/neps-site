require 'redcarpet'
require 'pygments.rb'

include Nanoc::Helpers::Rendering

def root_item
  @items.detect { |i| i.identifier == '/' }
end

def neps
  @items.select { |i| i.identifier =~ %r{^/NEP-.+} }.sort_by { |i| i[:number] }
end

def link_to_nep(nep)
  %[<a href="#{nep.path}" class="#{nep[:status]}">NEP-#{nep[:number]}: #{nep[:title]}</a>]
end

class ColorizedHTMLRenderer < Redcarpet::Render::HTML

  def block_code(code, language)
    Pygments.highlight(code, :lexer => language)
  end

end
