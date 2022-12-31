require "psych"
require "securerandom"
require_relative "loader"
require_relative "validator"

module Marko
  # default abstract starters that must be replugged later
  # LoaderPlug = Loader.plug
  # ValidatorPlug = Validator.plug

  # @todo maybe it should ask reporsitory for artifact?
  def self.artifact
    File.exist?(ARTIFACT) ? read : create
  end

  protected

  Artifact = Struct.new(:id, :title, :template, :filename)

  ARTIFACT = 'marko.yml'

  def create
    art = Artifact.new(
      SecureRandom.uuid,
      'Marko Artifact',
      'artifact.md.tt',
      'marko-artifact')
    File.write(ARTIFACT, Psych.dump(art))
    art.freeze
  end

  def read
    Psych.load_file(ARTIFACT).freeze
  end

end
