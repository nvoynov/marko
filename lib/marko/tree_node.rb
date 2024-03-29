# frozen_string_literal: true

require "forwardable"
require_relative "gadgets"

module Marko

  MustbeString = Sentry.new(:key, "must be String"
  ) {|v| v.is_a? String}

  MustbeTreeNode = Sentry.new(:key, "must be TreeNode"
  ) {|v| v.is_a? TreeNode}

  class TreeNode
    extend Forwardable
    include Enumerable

    attr_reader :parent
    attr_reader :title
    attr_reader :meta
    attr_reader :body

    def_delegators :@meta, :[], :[]=
    def_delegator :@items, :last
    def_delegator :@items, :delete, :delete_item
    def_delegator :@meta, :delete, :delete_meta
    def_delegator :@parent, :id, :parent_id

    def initialize(title = '', body = '', **meta)
      @parent, @items = nil, []
      @title = MustbeString.(title, :title)
      @body = MustbeString.(body, :body)
      @meta = meta
    end

    def <<(node)
      MustbeTreeNode.(node)
      node.parent = self
      @items << node
      node
    end

    # see Enumerable#each
    def each(&block)
      return to_enum(__callee__) unless block_given?
      yield(self)
      items.each{|n| n.each(&block) }
    end

    # @return [Array<String>]
    def order_index
      @meta
        .fetch(:order_index, '')
        .strip.split(/\s{1,}/)
    end

    def id
      meta.fetch(:id, '').then{|s|
        s = parent.id + s if s.start_with?(?.) && parent
        s
      }
    end

    def find_item(ref)
      @items.find{|n| n.id == ref || n.id.end_with?(ref)}
    end

    def find_node(ref)
      return find_item(ref) if ref.start_with?(?.)
      fu = proc{|n| n.id == ref}
      find(&fu).then{|n| n ? n : root.find(&fu) }
    end

    # @return [Array<Node>] ordered list of child nodes
    def items
      return @items unless order_index.any?
      [].tap do |ary|
        src = Array.new(@items)
        order_index.each do |i|
          node = find_item(i)
          ary << src.delete(node) if node
        end
        ary.concat(src)
      end
    end

    def belongs_to?(ref)
      parent.then{|n|
        n = n.parent while n && n.id != ref
        n&.id == ref
      }
    end

    # @return [Node] the root node in the node hierarchy
    def root
      self.then{|n|
        n = n.parent while n.parent
        n
      }
    end

    def root?
      parent.nil?
    end

    # @return [Integer] the node level in the node hierarchy
    def nesting_level
      root? ? 0 : parent.nesting_level + 1
    end

    # @return [Array<String>] macro links in the node #body  IT IS RATHER MACRO FOR WRITER SO TI SHOULD BE PROCESSED APPROPRIATELY
    def links
      return [] if @body.empty?
      @body.scan(/\[\[([\w\.]*)\]\]/).flatten.uniq
    end

    def orphan!
      return unless @parent
      @parent.delete_item(self)
      @parent = nil
    end

    protected

    def parent=(node)
      @parent = MustbeTreeNode.(node)
    end

  end

end
