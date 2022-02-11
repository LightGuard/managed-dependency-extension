package io.github.gastaldi.asciidoctor;

import org.asciidoctor.Asciidoctor;
import org.asciidoctor.Attributes;
import org.asciidoctor.Options;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class ManagedDependencyExtensionTest {

    @Test
    void extensionIsRegistered() {
        Attributes attributes = Attributes.builder()
                .attribute("quarkus-version", "2.7.1.Final")
                .build();
        Asciidoctor asciidoctor = Asciidoctor.Factory.create();
        Options options = Options.builder()
                .attributes(attributes)
                .backend("html5")
                .build();
        String converted = asciidoctor.convert("Hello version:io.smallrye.common:smallrye-common-constraint[]", options);
        assertThat(converted).contains("Hello 1.8.0");
    }
}