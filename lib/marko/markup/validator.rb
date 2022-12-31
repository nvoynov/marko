# frozen_string_literal: true

require_relative "../validator"

module Marko
  module Markup
    class Validator < Marko::Validator

      def initialize
        @inspectors = []
        @inspectors << TheSameId.new
        @inspectors << LostParent.new
        @inspectors << LostIndex.new
        @inspectors << LostLink.new
      end

      # see Marko::Validator#call
      def call(tree)
        [].tap{|errors|
          @inspectors.each{|spectr| errors.concat(spectr.(tree)) }
        }
      end

    end

    class Inspector
      def call(tree)
        select(tree).then{ report(_1) }
      end

      def select(tree)
        fail "the abstract method must be overriden"
      end

      def report(errs)
        fail "the abstract method must be overriden"
      end

    end

    class TheSameId < Inspector
      def select(tree)
        fn = proc{|n, memo| memo[n.id] ||= []; memo[n.id] << n}
        tree
          .each_with_object({}, &fn)
          .select{|_, v| v.size > 1}
      end

      def report(errs)
        # the same id [ref] found twice
        #   src/source2.md:22 >> ## header
        #   src/source3.md:11 >> ## header
        errs.map{|id, nodes|
          sources = nodes.map{|n| "  #{n[:origin]}\n"}.join
          "the same id [#{id}] found in\n#{sources}\n"
        }
      end
    end

    class LostParent < Inspector
      def select(tree)
        tree.select{|n| n[:parent] && n.parent_id != n[:parent]}
      end

      def report(errs)
        # lost parent [ref] src/source2.md:22 >> ## header
        errs.map{|n| "lost parent [#{n[:parent]}] found in #{n[:origin]}\n"}
      end
    end

    class LostIndex < Inspector
      def select(tree)
        lost = proc{|n| n.order_index.reject{|i| n.find_item(i)}}
        tree
          .select{|n| n.order_index.any? && lost.(n).any?}
          .map{|n| [n[:origin], lost.(n)]} # @todo second time calculation
      end

      def report(errs)
        # lost index [a, b] src/source2.md:22 >> ## header
        errs.map{|orig, lost| "lost index [#{lost.join(', ')}] in #{orig}\n" }
      end
    end

    class LostLink < Inspector
      def select(tree)
        lost = proc{|n| n.links.reject{|i| n.find_node(i)}}
        tree
          .select{|n| lost.(n).any? }
          .map{|n| [n[:origin], lost.(n)]} # @todo second time #lost calculation
      end

       # @todo report link line number in the origin
      def report(errs)
        # lost links [ref] src/source2.md:22 >> ## header
        errs.map{|orig, lost| "lost link [#{lost.join(', ')}] in #{orig}\n"}
      end
    end

  end
end
