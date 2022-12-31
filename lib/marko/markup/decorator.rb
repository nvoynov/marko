# frozen_string_literal: true

require "delegate"

module Marko
  module Markup

    class Decorator < SimpleDelegator

      def initialize(obj)
        super(obj)
        @macroproc = MacroProcPlug.plugged
      end

      def find_node(ref)
        obj = super(ref)
        return nil unless obj
        self.class.new(obj)
      end

      def url
        id.downcase
          .gsub(/\W{1,}/, '-')
          .gsub(/^-/, '')
          .gsub(/-$/, '')
          .then{"##{_1}"}
      end

      def ref
        "[#{title}](#{url})"
      end

      def title
        str = super
        str = ".#{id.split(/\./).last}" if str.empty?
        str
      end

      def header
        return "% #{title}\n" if root?
        "#{'#' * nesting_level} #{title.strip} {#{url}}\n"
      end

      def meta
        hsh = super.dup
        hsh[:id] = id # full id will be there
        hsh.delete(:order_index)
        hsh.delete(:parent)
        hsh.delete(:origin)
        len = hsh.keys.map(&:length).max
        [].tap{|ary|
          ary << "key | value"
          ary << "--- | -----"
          hsh.each{|k,v| ary << "#{k} | #{v}"}
        }.join(?\n) + ?\n
      end

      def body
        text = @macroproc.process(super, self)
        text.strip + ?\n
      end
    end

  end
end
