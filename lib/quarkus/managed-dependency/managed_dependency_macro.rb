require 'asciidoctor'
require 'asciidoctor/extensions'

module Quarkus::ManagedDependency
  class ManagedDependencyMacro < ::Asciidoctor::Extensions::InlineMacroProcessor
    use_dsl

    named :version

    def process(parent, target, attributes)
      (group_id, artifact_id) = target.split(':')
    end
  end
end
