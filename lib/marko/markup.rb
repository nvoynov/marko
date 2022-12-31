require_relative "markup/parser"
require_relative "markup/storage"
require_relative "markup/validator"
require_relative "markup/macro"
require_relative "markup/decorator"
require_relative "markup/compiler"

module Marko

  ParserPlug = Markup::Parser.plug
  StoragePlug = Markup::Storage.plug
  MacroProcPlug = Markup::MacroProcessor.plug
  ValidatorPlug = Markup::Validator.plug
  CompilerPlug = Markup::Compiler.plug

end
