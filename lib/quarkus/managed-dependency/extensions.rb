# frozen_string_literal: true

require 'asciidoctor' unless defined? Asciidoctor.load
require_relative 'managed_dependency_macro'

module Quarkus::ManagedDependency
  module Extensions
    module_function

    def group
      proc do
        next if document.options[:dep_version]
        inline_macro ManagedDependencyMacro
      end
    end

    def prepare_registry registry = nil
      registry = ::Asciidoctor::Extensions.create(&registry) if ::Proc === registry
      unless ::Asciidoctor::Extensions.groups[:dep_version]
        if registry
          registry.groups[:dep_version] = group
        else
          registry = ::Asciidoctor::Extensions.create :dep_version, &group
        end
      end
      registry
    end

    def register
      ::Asciidoctor::Extensions.register :dep_version, &group
    end

    def unregister
      ::Asciidoctor::Extensions.unregister :dep_version
    end
  end
end