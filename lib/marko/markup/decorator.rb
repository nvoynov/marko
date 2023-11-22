# frozen_string_literal: true

require "delegate"

module Marko
  module Markup

    class Decorator < SimpleDelegator

      def initialize(obj)
        super(obj)
        @macroproc = MacroProcPlug.plugged
      end

      def title
        super.then{|s| s.empty? ? ".#{id.split(/\./).last}" : s}
      end

      def body
        @macroproc.process(super, self).strip
      end

      # @return [Hash] metdata cleaned from system meta
      def meta
        super.dup.tap{|h| h.update(id: id)}
          .reject{|k,_| %i[origin parent order_index].include?(k)}
      end

      def find_node(ref)
        obj = super(ref)
        return nil unless obj
        self.class.new(obj)
      end

      def ref
        "[#{title}](#{url})"
      end

      # @return [String] return header
      def topic
        return "% #{title}" if root?
        "#{'#' * nesting_level} #{title.strip} {#{url}}"
      end
      alias :header :topic

      # return [String] meta properties table
      def props
        meta.then{|h|
          klen = h.keys.map{ _1.to_s.size }.max + 4
          vlen = h.values.map(&:size).max
          mark = ?- * klen + ?\s + ?- * vlen
          h.map{|k, v| "__#{k.capitalize}__".ljust(klen) + ?\ + v }
            .unshift(mark)
            .push(mark)
            .join(?\n)
        }
      end

      # @return [String] decorated node content
      def text
        [ topic, props, body
        ].reject(&:empty?)
         .join("\n\n") +
         "\n\n"
      end

      protected

      def url
        id.downcase
          .gsub(/\W{1,}/, '-')
          .gsub(/^-/, '')
          .gsub(/-$/, '')
          .then{"##{_1}"}
      end

    end

  end
end
