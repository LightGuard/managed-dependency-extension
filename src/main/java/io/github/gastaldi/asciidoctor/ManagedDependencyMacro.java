package io.github.gastaldi.asciidoctor;

import org.asciidoctor.Options;
import org.asciidoctor.ast.ContentNode;
import org.asciidoctor.extension.InlineMacroProcessor;
import org.asciidoctor.extension.Name;

import java.util.Map;

@Name("version")
public class ManagedDependencyMacro extends InlineMacroProcessor {

    @Override
    public Object process(ContentNode parent, String ga, Map<String, Object> attributes) {
        Map<String, String> docAttrs = (Map<String, String>) parent.getDocument().getOptions().get(Options.ATTRIBUTES);
        String quarkusVersion = docAttrs.get("quarkus-version");
        String[] split = ga.split(":");
        String groupId = split[0];
        String artifactId = split[1];
        Resolver resolver = Resolver.forVersion(quarkusVersion);
        return resolver.findVersion(groupId, artifactId)
                .map(v -> createPhraseNode(parent, "quoted", v, attributes))
                .orElse(null);
    }
}
