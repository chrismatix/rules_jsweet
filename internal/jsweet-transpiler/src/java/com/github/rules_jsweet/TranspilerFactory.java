package com.github.rules_jsweet;

import org.jsweet.transpiler.JSweetTranspiler;

public class TranspilerFactory {

    static JSweetTranspiler getTranspiler(final TranspileCommand command) {
        final JSweetTranspiler transpiler = new JSweetTranspiler(command.baseDirectory,
                null,
                null,
                command.workingDirectory,
                command.tsOutputDir,
                null,
                null,
                command.classPath);

        transpiler.setTscWatchMode(false);

        return transpiler;
    }
}
