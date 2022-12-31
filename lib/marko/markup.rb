require_relative "markup/parser"
require_relative "markup/storage"
require_relative "markup/validator"
require_relative "markup/macro"
require_relative "markup/decorator"
require_relative "markup/compiler"
require_relative "config"


module Marko

  ParserPlug.plug Markup::Parser
  StoragePlug.plug Markup::Storage
  CompilerPlug.plug Markup::Compiler
  ValidatorPlug.plug Markup::Validator

  # ParserPlug = Markup::Parser.plug
  # StoragePlug = Markup::Storage.plug
  # @todo let Decorator know
  MacroProcPlug = Markup::MacroProcessor.plug
  # ValidatorPlug = Markup::Validator.plug
  # CompilerPlug = Markup::Compiler.plug

end
