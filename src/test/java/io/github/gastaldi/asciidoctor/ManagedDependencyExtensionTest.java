package io.github.gastaldi.asciidoctor;

import org.asciidoctor.Asciidoctor;
import org.asciidoctor.Attributes;
import org.asciidoctor.Options;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class ManagedDependencyExtensionTest {

    @Test
    void extensionIsRegistered() {
        Asciidoctor asciidoctor = Asciidoctor.Factory.create();
        Options options = Options.builder()
                .attributes(Attributes.builder()
                        .attribute("quarkus-version","2.7.1.Final")
                        .backend("html5").build())
                .build();
        String converted = asciidoctor.convert("This example uses SmallRye Config version:io.smallrye.config:smallrye-config[]", options);
        assertThat(converted).contains("This example uses SmallRye Config 2.8.2");
    }
}