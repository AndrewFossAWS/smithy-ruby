/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

package software.amazon.smithy.ruby.codegen.generators;

import software.amazon.smithy.codegen.core.SymbolProvider;
import software.amazon.smithy.codegen.core.directed.ContextualDirective;
import software.amazon.smithy.ruby.codegen.GenerationContext;
import software.amazon.smithy.ruby.codegen.RubySettings;

abstract class TypesFileGenerator {
    final SymbolProvider symbolProvider;
    final RubySettings settings;

    final GenerationContext context;

    TypesFileGenerator(ContextualDirective<GenerationContext, RubySettings> directive) {
        this.symbolProvider = directive.symbolProvider();
        this.settings = directive.settings();
        this.context = directive.context();
    }

    public final String nameSpace() {
        return settings.getModule() + "::Types";
    }

    public final String rbFile() {
        return settings.getGemName() + "/lib/" + settings.getGemName() + "/types.rb";
    }

    public final String rbsFile() {
        return settings.getGemName() + "/sig/" + settings.getGemName() + "/types.rbs";
    }
}