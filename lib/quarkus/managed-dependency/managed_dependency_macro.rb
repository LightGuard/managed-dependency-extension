# frozen_string_literal: true

module Quarkus::ManagedDependency
  class ManagedDependencyMacro < ::Asciidoctor::Extensions::InlineMacroProcessor
    use_dsl

    named :version

    def process(parent, target, attributes)
      (group_id, artifact_id) = target.split(':')

      # Find what we need: http://xpather.com/85iiY0go
    end
  end
end
