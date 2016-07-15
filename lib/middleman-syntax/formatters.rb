module Middleman
  module Syntax
    module Formatters
      class HTML < Rouge::Formatter
        tag 'html'

        def initialize(opts={})
          @opts = { table_class: 'table', gutter_class: 'gutter', code_class: 'code' }.merge(opts)
          @formatter = if opts[:inline_theme]
                         Rouge::Formatters::HTMLInline.new(opts[:inline_theme])
                       else
                         Rouge::Formatters::HTML.new
                       end

          @formatter = Rouge::Formatters::HTMLTable.new(@formatter, opts) if opts[:line_numbers]

          if opts.fetch(:wrap, true)
            @formatter = Rouge::Formatters::HTMLPygments.new(@formatter, opts.fetch(:css_class, 'codehilite'))
          end
        end

        def stream(tokens, &block)
          @formatter.stream(tokens, &block)
        end
      end
    end
  end
end
