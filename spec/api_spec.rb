# frozen_string_literal: true

require_relative 'spec_helper'

describe Quarkus::ManagedDependency do
  it 'should work with a quarkus version as a document attribute' do
    doc = process_string 'This example uses SmallRye Config version:io.smallrye.config:smallrye-config[]',
                         attributes: {'quarkus-version' => '2.7.1.Final'}
    (expect doc.convert).to eql "<div class=\"paragraph\">\n<p>This example uses SmallRye Config 2.8.2</p>\n</div>"
  ensure
    Quarkus::ManagedDependency::Extensions.unregister
  end

  it 'should work with a quarkus version as a macro attribute' do
    doc = process_string 'This example uses SmallRye Config version:io.smallrye.config:smallrye-config[2.7.1.Final]'

    (expect doc.convert).to eql "<div class=\"paragraph\">\n<p>This example uses SmallRye Config 2.8.2</p>\n</div>"
  ensure
    Quarkus::ManagedDependency::Extensions.unregister
  end
end