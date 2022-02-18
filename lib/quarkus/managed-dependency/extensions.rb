# frozen_string_literal: true

require 'asciidoctor' unless defined? Asciidoctor.load
require_relative 'preprocessor'
require_relative 'tree_processor'

module Quarkus::MangedDependency
  module Extensions
    module_function

    def prepare_registry registry = nil
      registry = ::Asciidoctor::Extensions.create(&registry) if ::Proc === registry
      unless ::Asciidoctor::Extensions.groups[:reducer]
        if registry
          registry.groups[:reducer] = group
        else
          registry = ::Asciidoctor::Extensions.create :reducer, &group
        end
      end
      registry
    end

    def register
      ::Asciidoctor::Extensions.register :reducer, &group
    end

    def unregister
      ::Asciidoctor::Extensions.unregister :reducer
    end
  end
end