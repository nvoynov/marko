# frozen_string_literal: true

require "forwardable"
require_relative "gadgets"
require_relative "config"
require_relative "loader"
require_relative "tree_node"

module Marko

  # The strategy for assembling sources into artifact tree
  class Assembler < Service
    extend Forwardable
    def_delegator :ValidatorPlug, :plugged, :validator

    class Failure # < StandardError
      attr_reader :errors
      def initialize(message, *errors)
        @errors = errors
        super(
          errors
            .map{|e| "\n  #{e.to_s}"}
            .unshift(message)
            .join
        )
      end
    end

    # @return [TreeNode]
    def call
      @block.(:stage, 'loading sources') if @block
      buffer, errors = Loader.(&@block)
      fail Failure.new('markup parsing failed', *errors) if errors.any?
      @block.(:stage, 'tree assemblage') if @block
      tree = assemble(buffer)
      @block.(:stage, 'tree enrichment') if @block
      injectid(tree)
      @block.(:stage, 'tree validation') if @block
      errors = validate(tree)
      fail Failure.new('tree validation failed', *errors) if errors.any?
      tree
    end

    protected

    # @param buff [Array<TreeNode>]
    # @return [TreeNode]
    def assemble(buff)
      art = Marko.artifact
      TreeNode.new(art.title, id: '0').tap {|root|
        # @todo buff.inject(root, :<<) wrong but why?
        buff.each{|n| root << n}
        root.items
          .select{|node| node[:parent] && node[:parent] != node.parent_id}
          .each{|node|
            parent = root.find{|n| n.id == node[:parent]}
            next unless parent # is must be left under root
            parent << node
            node.delete_meta(:parent)
            root.delete_item(node)
          }
      }
    end

    def injectid(tree)
      counter = {}
      tree
        .select {|node| node.id.empty?}
        .each do |node|
          index = counter[node.parent] || 1
          counter[node.parent] = index + 1
          id = index.to_s.rjust(2, '0')
          id = '.' + id unless node.parent == tree
          node[:id] = id
        end
    end

    def validate(tree)
      validator.(tree)
    end

  end

end
