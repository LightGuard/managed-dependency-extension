# frozen_string_literal: true

require_relative 'spec_helper'

describe Quarkus::ManagedDependency::Extensions do
  describe '.group' do
    subject { described_class.method :group }

    it 'should return extension group' do
      group = subject.call
      (expect group).to be_kind_of Proc
      doc = Asciidoctor.load []
      reg = (Asciidoctor::Extensions.create :dep_version, &group).activate doc
      (expect reg.inline_macros).to have_size 1
    end
  end

  describe '.prepare_registry' do
    subject { described_class.method :prepare_registry }

    it 'should prepare a new registry if no registry is specified' do
      registry = subject.call
      (expect registry).not_to be_nil
      (expect registry.groups.keys).to have_size 1
      (expect registry.groups[:dep_version]).not_to be_nil
    end
  end

  describe '.register' do
    subject { described_class.method :register }

    it 'should require extensions globally under group named reducer' do
      subject.call
      (expect Asciidoctor::Extensions.groups).to have_key :dep_version
      doc = Asciidoctor.load []
      reg = Asciidoctor::Extensions::Registry.new.activate doc
      (expect reg.inline_macros).to have_size 1
    ensure
      described_class.unregister
    end
  end
end