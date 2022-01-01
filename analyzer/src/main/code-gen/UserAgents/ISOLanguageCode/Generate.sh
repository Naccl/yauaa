#!/bin/bash
# Yet Another UserAgent Analyzer
# Copyright (C) 2013-2022 Niels Basjes
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
TARGETDIR=$(cd "${SCRIPTDIR}/../../../resources/UserAgents" || exit 1; pwd)

INPUT1="${SCRIPTDIR}/ISOLanguageCodes.csv"
INPUT2="${SCRIPTDIR}/iso-639-3.tab"
UNWANTED="${SCRIPTDIR}/unwanted-language-codes.txt"
OUTPUT="${TARGETDIR}/ISOLanguageCode.yaml"

[ "$1" = "--force" ] && rm "${OUTPUT}"

if [ "Generate.sh" -ot "${OUTPUT}" ]; then
    if [ "${INPUT1}" -ot "${OUTPUT}" ] && [ "${INPUT2}" -ot "${OUTPUT}" ] && [ "${UNWANTED}" -ot "${OUTPUT}" ] ; then
        echo "Up to date: ${OUTPUT}";
        exit;
    fi
fi

echo "Generating: ${OUTPUT}";

(
echo "# ============================================="
echo "# THIS FILE WAS GENERATED; DO NOT EDIT MANUALLY"
echo "# ============================================="
echo "#"
echo "# Yet Another UserAgent Analyzer"
echo "# Copyright (C) 2013-2022 Niels Basjes"
echo "#"
echo "# Licensed under the Apache License, Version 2.0 (the \"License\");"
echo "# you may not use this file except in compliance with the License."
echo "# You may obtain a copy of the License at"
echo "#"
echo "# https://www.apache.org/licenses/LICENSE-2.0"
echo "#"
echo "# Unless required by applicable law or agreed to in writing, software"
echo "# distributed under the License is distributed on an \"AS IS\" BASIS,"
echo "# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied."
echo "# See the License for the specific language governing permissions and"
echo "# limitations under the License."
echo "#"

echo ""
echo "config:"

echo "# Match the 2 and 2-2 letter variants:"

echo "- matcher:"
echo "    extract:"
echo "    - 'AgentLanguageCode                   :      100 :LookUp[ISOLanguageCodesAll    ;agent.(1-20)text]'"
echo "    - 'AgentLanguage                       :      100 :LookUp[ISOLanguageCodesNameAll;agent.(1-20)text]'"

echo "- matcher:"
echo "    extract:"
echo "    - 'AgentLanguageCode                   :   500006 :LookUp[ISOLanguageCodesAll    ;agent.(1)product.(1)comments.entry.(1)text]'"
echo "    - 'AgentLanguage                       :   500006 :LookUp[ISOLanguageCodesNameAll;agent.(1)product.(1)comments.entry.(1)text]'"
echo ""

echo "- matcher:"
echo "    extract:"
echo "    - 'AgentLanguageCode                   :   500005 :LookUp[ISOLanguageCodesAll    ;agent.(1)product.(1)comments.entry.(2)text]'"
echo "    - 'AgentLanguage                       :   500005 :LookUp[ISOLanguageCodesNameAll;agent.(1)product.(1)comments.entry.(2)text]'"
echo ""

echo "- matcher:"
echo "    extract:"
echo "    - 'AgentLanguageCode                   :   500000 :LookUp[ISOLanguageCodesAll    ;agent.(2-8)product.(1)comments.(1-5)entry.(1-2)text]'"
echo "    - 'AgentLanguage                       :   500000 :LookUp[ISOLanguageCodesNameAll;agent.(2-8)product.(1)comments.(1-5)entry.(1-2)text]'"
echo ""

echo "- matcher:"
echo "    extract:"
echo "    - 'AgentLanguageCode                   :   500004 :LookUp[ISOLanguageCodesAll    ;agent.(1-2)product.(2)comments.(1-5)entry.(1-2)text]'"
echo "    - 'AgentLanguage                       :   500004 :LookUp[ISOLanguageCodesNameAll;agent.(1-2)product.(2)comments.(1-5)entry.(1-2)text]'"
echo ""

echo "- matcher:"
echo "    extract:"
echo "    - 'AgentLanguageCode                   :   500004 :LookUp[ISOLanguageFullCodes    ;agent.(2-8)product.(1)comments.(1-5)entry.(1)product.(1)name]'"
echo "    - 'AgentLanguage                       :   500004 :LookUp[ISOLanguageFullCodesName;agent.(2-8)product.(1)comments.(1-5)entry.(1)product.(1)name]'"
echo ""

echo "- matcher:"
echo "    extract:"
echo "    - 'AgentLanguageCode                   :   500004 :LookUp[ISOLanguageFullCodes    ;agent.(1-2)product.(1)comments.(1-5)entry.(1)product.(1)name]'"
echo "    - 'AgentLanguage                       :   500004 :LookUp[ISOLanguageFullCodesName;agent.(1-2)product.(1)comments.(1-5)entry.(1)product.(1)name]'"
echo ""

echo "- matcher:"
echo "    extract:"
echo "    - 'AgentLanguageCode                   :   500008 :LookUp[ISOLanguageCodesAll    ;agent.product.name=\"Language\"^.version]'"
echo "    - 'AgentLanguage                       :   500008 :LookUp[ISOLanguageCodesNameAll;agent.product.name=\"Language\"^.version]'"
echo ""

echo "# -----------------------------------------------------------------------------"
echo "- lookup:"
echo "    name: 'ISOLanguageCodesAll'"
echo "    merge:"
echo "    - 'ISOLanguageCodes'"
echo "    - 'ISOLanguageCodes3'"

echo "- lookup:"
echo "    name: 'ISOLanguageCodesNameAll'"
echo "    merge:"
echo "    - 'ISOLanguageCodesName'"
echo "    - 'ISOLanguageCodes3Name'"

echo "# -----------------------------------------------------------------------------"

echo "- lookup:"
echo "    name: 'ISOLanguageFullCodes'"
echo "    map:"
grep -F -v '#' "${INPUT1}" | grep -F -- '-' | while read -r line
do
    CODE=$(echo "${line}" | cut -d' ' -f1)
    echo "      \"${CODE}\" : \"${CODE}\""
done

echo "# -----------------------------------------------------------------------------"
echo "- lookup:"
echo "    name: 'ISOLanguageFullCodesName'"
echo "    map:"
grep -F -v '#' "${INPUT1}" | grep -F -- '-' | while read -r line
do
    CODE=$(echo "${line}" | cut -d' ' -f1)
    NAME=$(echo "${line}" | cut -d' ' -f2-)
    echo "      \"${CODE}\" : \"${NAME}\""
done

echo "# -----------------------------------------------------------------------------"

echo "- lookup:"
echo "    name: 'ISOLanguageCodes'"
echo "    map:"
grep -F -v '#' "${INPUT1}" | grep . | while read -r line
do
    CODE=$(echo "${line}" | cut -d' ' -f1)
    echo "      \"${CODE}\" : \"${CODE}\""
    if [[ ${CODE} = *"-"* ]]; then
        echo "      \"${CODE//-/_}\" : \"${CODE}\""
        echo "      \"${CODE//-/}\" : \"${CODE}\""
    fi
done

echo "# -----------------------------------------------------------------------------"
echo "- lookup:"
echo "    name: 'ISOLanguageCodesName'"
echo "    map:"
grep -F -v '#' "${INPUT1}" | grep . | while read -r line
do
    CODE=$(echo "${line}" | cut -d' ' -f1)
    NAME=$(echo "${line}" | cut -d' ' -f2-)
    echo "      \"${CODE}\" : \"${NAME}\""
    if [[ ${CODE} = *"-"* ]]; then
        echo "      \"${CODE//-/_}\" : \"${NAME}\""
        echo "      \"${CODE//-/}\" : \"${NAME}\""
    fi
done

echo "# -----------------------------------------------------------------------------"
echo "- lookup:"
echo "    name: 'ISOLanguageCodes3'"
echo "    map:"
cat "${INPUT2}" | while read -r line
do
    CODE=$(echo "${line}" | cut -d'	' -f1)
    echo "      \"${CODE}\" : \"${CODE}\""
done

echo "# -----------------------------------------------------------------------------"
echo "- lookup:"
echo "    name: 'ISOLanguageCodes3Name'"
echo "    map:"
cat "${INPUT2}" | while read -r line
do
    CODE=$(echo "${line}" | cut -d'	' -f1)
    NAME=$(echo "${line}" | cut -d'	' -f7)
    echo "      \"${CODE}\" : \"${NAME}\""
done
echo "# -----------------------------------------------------------------------------"

) | grep -F -v -f "${UNWANTED}" >"${OUTPUT}"

