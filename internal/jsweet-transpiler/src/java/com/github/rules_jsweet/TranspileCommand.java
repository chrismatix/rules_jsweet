package com.github.rules_jsweet;

import java.io.File;
import java.util.concurrent.Callable;

import org.jsweet.transpiler.JSweetTranspiler;
import picocli.CommandLine.Command;
import picocli.CommandLine.Option;

import static com.github.rules_jsweet.TranspilerFactory.getTranspiler;


@Command
class TranspileCommand implements Callable<Integer> {

    @Option(names = "--baseDir")
    File baseDirectory;

    @Option(names = "--cwd")
    File workingDirectory;

    @Option(names = "--tsOut")
    File tsOutputDir;

    @Option(names = "--classPath")
    String classPath;

    @Override
    public Integer call() {
        final JSweetTranspiler transpiler = getTranspiler(this);

        // TODO maybe?

        return 123; // exit code
    }

}
