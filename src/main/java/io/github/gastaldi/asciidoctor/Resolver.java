package io.github.gastaldi.asciidoctor;

import io.fabric8.maven.Maven;
import org.apache.maven.model.Dependency;
import org.apache.maven.model.Model;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UncheckedIOException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Optional;

public class Resolver {
    private static final String URL_TEMPLATE = "https://repo1.maven.org/maven2/io/quarkus/quarkus-bom/%1$s/quarkus-bom-%1$s.pom";

    private final Model bom;

    public static final Resolver forQuarkusVersion(String version) {
        // FIXME Cache the Resolver
        return new Resolver(version);
    }

    private Resolver(String quarkusVersion) {
        // TODO Use Maven Resolver API instead
        try (InputStream is = new URL(String.format(URL_TEMPLATE, quarkusVersion)).openStream();
                InputStreamReader reader = new InputStreamReader(is, StandardCharsets.UTF_8)) {
            this.bom = Maven.readModel(reader);
        } catch (IOException io) {
            throw new UncheckedIOException("Error while reading BOM", io);
        }
    }

    public Optional<String> findVersion(String groupId, String artifactId) {
        return bom.getDependencyManagement().getDependencies()
                .stream()
                .filter(d -> groupId.equals(d.getGroupId()) && artifactId.equals(d.getArtifactId()))
                .map(Dependency::getVersion)
                .findFirst();
    }

}
