# frozen_string_literal: true

require_relative "../parser"
require_relative "../tree_node"

module Marko
  module Markup

    class Parser < Marko::Parser

      # @see Parser#call
      def call(content, source, &block)
        @source = source
        parse(content, &block)
      end

      protected

      def parse(content, &block)
        result, errors = [], [], []
        scan_treenode(content)
          .map{|origin|
            begin
              parse_treenode(origin.markup)
                .tap{|n| n[:origin] = origin }
            rescue => e
              errmsg = "wrong markup #{origin} #{e.message}"
              errors << errmsg
              nil
            end
          }
          .compact
          .each{|node|
            parent = find_parent(result, node[:origin].level)
            unless parent
              origin = node[:origin].to_s
              errors << "wrong header #{origin}"
              parent = result # it goes to the root!
            end
            parent << node
          }

        [result, errors]
      end

      def find_parent(ary, level)
        return ary if level == 1
        parent = ary.last
        l = 1
        while parent && (l+1) < level
          parent = parent.last
          l += 1
        end
        parent
      end

      Origin = Struct.new(:origin, :lineno, :markup) do
        def header
          @header ||= markup.lines.first
        end

        def level
          @level ||= header.scan(/^#*/).first.size
        end

        def to_s
          "#{origin}:#{lineno.to_s.rjust(2,'0')} >> #{header}".strip
        end
      end

      # @return [Array<Origin>]
      def scan_treenode(text)
        quote, buffer, lineno = false, [], 0
        origin = proc{
          Origin.new(@source, lineno - buffer.size + 1, buffer.join(''))
        }

        [].tap{|ary|
          text.each_line do |line|
            if line =~ /^#/ && !quote && buffer.any?
              ary << origin.()
              buffer.clear
            end
            lineno += 1
            buffer << line
            quote = !quote if line.start_with?('```')
          end
          ary << origin.() if buffer.any?
        }
      end

      def parse_treenode(text)
        head, *tail = text.lines
        m = head.match(/^(#+)(.*)/)
        title = m[2]&.strip || ''

        m = tail.join.match(/^({{([\s\S]*?)}})?(.*)?$/m)
        meta = parse_metadata(m[2]&.strip || '')
        body = m[3]&.strip || ''

        TreeNode.new(title, body, **meta)
      end

      def parse_metadata(text)
        return {} if text.empty?
        atrbfn = method(:parse_attribute).to_proc
        text
          .split(/[;,\n]/)
          .map(&:strip)
          .reject(&:empty?)
          .map(&atrbfn)
          .to_h
      end

      def parse_attribute(text)
        atr, val = text.split(?:)
        [atr.strip.to_sym, val&.strip || 'true']
      end
    end

  end
end
