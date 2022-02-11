Managed Dependency Asciidoctor Extension
=========================================

This is an AsciidoctorJ extension that outputs the managed dependency version of a given groupId:artifactId, based on a BOM

Example: 

```asciidoc
This example uses SmallRye Config version:io.smallrye.config:smallrye-config[] 
```

This will output the following if the `:quarkus-version: 2.7.1.Final` is defined for the asciidoctor engine configuration: 

```
This example uses SmallRye Config 2.8.2
```
