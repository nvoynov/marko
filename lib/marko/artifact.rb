module Marko
  Artifact = Struct.new(:title, :template, :filename)
  NULLFACT = Artifact.new("Artifact",
    "tt/default.md.tt", "bin/artifact.md") .freeze 
end
