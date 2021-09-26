/*
 * Yet Another UserAgent Analyzer
 * Copyright (C) 2013-2021 Niels Basjes
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package nl.basjes.parse.useragent.beam;

import nl.basjes.parse.useragent.UserAgentAnalyzer;
import org.apache.beam.sdk.extensions.sql.BeamSqlUdf;

abstract class BaseParseUserAgentUDF implements BeamSqlUdf {
    private static transient UserAgentAnalyzer userAgentAnalyzer = null;

    protected static UserAgentAnalyzer getInstance() {
        // NOTE: We currently do NOT make an instance with only the wanted fields.
        //       We only know the required parameters the moment the call is done.
        //       At that point it is too late to create an optimized instance.
        if (userAgentAnalyzer == null) {
            userAgentAnalyzer = UserAgentAnalyzer
                .newBuilder()
                .immediateInitialization()
                .dropTests()
                .build();
        }
        return userAgentAnalyzer;
    }
}
