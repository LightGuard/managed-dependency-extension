# frozen_string_literal: true
require 'rexml'
require 'open-uri'

module Quarkus::ManagedDependency
  class ManagedDependencyMacro < ::Asciidoctor::Extensions::InlineMacroProcessor
    use_dsl

    named :version
    name_positional_attributes 'quarkus-version'

    def process(parent, target, attributes)
      (group_id, artifact_id) = target.split(':')
      quarkus_version = attributes['quarkus-version'] || parent.document.attributes['quarkus-version']

      # Find what we need: http://xpather.com/85iiY0go
      dep_version_xpath_template = '//dependencyManagement/dependencies/dependency[groupId="%s" and artifactId="%s"]/version'
      quarkus_pom_url_template = 'https://repo1.maven.org/maven2/io/quarkus/quarkus-bom/%s/quarkus-bom-%s.pom'
      quarkus_pom = REXML::Document.new URI.open(quarkus_pom_url_template % [quarkus_version, quarkus_version])
      quarkus_pom.get_text dep_version_xpath_template % [group_id, artifact_id]
    end
  end
end
