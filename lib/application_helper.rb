require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
require 'logger'

module ApplicationHelper
    class HtmlWithRouge < Redcarpet::Render::HTML
        include Rouge::Plugins::Redcarpet
    end

    def self.markdown(text)
        render = HtmlWithRouge.new
        md = Redcarpet::Markdown.new(render,
            tables: true,
            autolink: true,
            superscript: true,
            strikethrough: true,
            no_intra_emphasis: true,
            fenced_code_blocks: true,
            space_after_headers: true
        )
        return md.render(text)
    end
  end
