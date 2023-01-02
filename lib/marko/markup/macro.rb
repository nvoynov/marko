# frozen_string_literal: true

require_relative "decorator"
require_relative "../gadgets"

module Marko
  module Markup

    # @todo confusing circular depenencies
    #    List/Tree/Link Macros -> Decorator
    #    Decorator#body -> MacroProcessor

    # Base class for macro substitutions
    # @example
    #   class Todo < Macro
    #     @pattern = /@@todo[^\n]*\n/
    #     def subs(sample, obj = nil)
    #       # code that returns <substitution>
    #       # for the sample parameter
    #     end
    #   end
    #
    #   text = "bla-bla-bla @@todo foo\nbla-bla-bla"
    #   Todo.new.gsub!(text)
    #   # => "bla-bla-bla <substitution for @@todo foo>"
    #
    class Macro
      def self.pattern
        @pattern
      end

      # @return [Regexp] pattern to process
      def pattern
        self.class.pattern
      end

      # substitutes all occured #pattern it text
      def gsub!(text, obj = nil)
        fn = subfn(text, obj)
        text.scan(pattern).each(&fn)
      end

      protected

      # build substitution for the text sample
      # @param sample [String] sample for substitution
      # @param obj [Object] might be used for substitution
      # @return [String] substitution for text
      def subs(sample, obj)
        fail '#subs must be overridden'
      end

      def subfn(source, obj)
        fn = proc{|source, obj, sample|
          source.sub!(sample, subs(sample, obj))
        }.curry
        fn.(source, obj)
      end
    end

    class MLink < Macro
      @pattern = /\[\[[\w\.]*\]\]/

      # the macro requires obj [Decorator]
      def subs(sample, node)
        capture = /\[\[([\w\.]*)\]\]/
        ref = sample
          .match(capture)
          .captures.first
        obj = node.find_node(ref)
        obj ? obj.ref : "[#{ref}](#lost-link)"
      end
    end

    class MList < Macro
      @pattern = /@@list/

      def subs(sample, node)
        # @todo require sentry Decorator
        # MustbeTreeNode.(node)
        node.items
          .map{|n| d = Decorator.new(n); "- #{d.ref}" }
          .join(?\n) + ?\n
      end
    end

    class MTree < Macro
      @pattern = /@@tree/

      def subs(sample, node)
        level = node.nesting_level + 1
        node.to_a.drop(1)
          .inject([]){|memo, n| memo << Decorator.new(n)}
          .map{|n| "#{'   ' * (n.nesting_level - level)}- #{n.ref}" }
          .join(?\n) + ?\n
      end
    end

    # @todo there is no sense to have such macro for releases
    #  instead it might be helpful to have some custom
    #  todo command that will create a file with nodes
    #  and list of todo for each node
    #
    # class MTodo < Macro
    #   @pattern = /@@todo[^\n]*\n/
    #
    #   def subs(sample, obj = nil)
    #     capture = /@@todo([^\n]*)\n/
    #     payload = sample.match(capture)
    #       .captures
    #       .first
    #       .strip
    #     "__TODO__ #{payload}\n"
    #   end
    # end

    # inline @@todo macro
    # @todo remove line with \n when it starts from @@todo
    class MTodo < Macro
      @pattern = /.*@@todo.*$/

      def subs(sample, obj = nil)
        cap = /(.*)@@todo.*$/
        m = sample.match(cap)
        m[1].strip + sample.gsub(pattern, '')
      end
    end

    class MSkip < Macro
      @pattern = /@@skip.*$/m

      def subs(sample, obj = nil)
        ''
      end
    end

    MustbeMacro = Sentry.new(:macro, "must be Macro"
    ) {|v| v.is_a? Macro }

    # Macro processor
    # @example
    #   processor = MacroProcessor.new
    #   processor << Toc.new
    #   processor << Todo.new
    #   processor.('bla bla @@todo, bla bla @@list')
    #   # => 'bla bla <substitute @@todo>, bla bla..'
    class MacroProcessor
      extend Marko::Pluggable

      def initialize
        @macros = {}
        self.<<(MList.new)
        self.<<(MTree.new)
        self.<<(MLink.new)
        self.<<(MTodo.new)
        self.<<(MSkip.new)
      end

      def <<(macro)
        MustbeMacro.(macro)
        @macros[macro.pattern] = macro
        macro
      end

      def process(text, obj)
        fail 'No macro registered' unless @macros.any?
        String.new(text).tap {|str|
          @macros.values.each{|m| m.gsub!(str, obj) }
        }
      end

      alias :call :process
    end

  end
end
