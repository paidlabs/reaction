module Reaction
  class Markdown
    def self.render(md_str)
      markdown.render(md_str)
    end

    def self.renderer
      @renderer ||= Redcarpet::Render::HTML.new
    end

    def self.markdown
      @markdown ||= Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    end
  end
end
