
require_relative "parser"
require_relative "storage"
require_relative "compiler"
require_relative "validator"

module Marko

  # default abstract starters that must be replugged later
  ParserPlug = Parser.plug
  StoragePlug = Storage.plug
  CompilerPlug = Compiler.plug
  ValidatorPlug = Validator.plug

  def self.artifact
    storage = StoragePlug.plugged
    storage.artifact
  end

end
