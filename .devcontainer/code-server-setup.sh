#!/bin/bash

# envbuilder does not yet support detection of extensions
set +e
declare -a extensions=($(sed 's/\/\/.*$//g' ./devcontainer.json | jq -r -M '[.customizations.vscode.extensions[]?, .extensions[]?] | .[]' ))

if [ "${extensions[0]}" != "" ] && [ "${extensions[0]}" != "null" ]; then
    for extension in "${extensions[@]}"; do
        code-server --install-extension "$extension"
    done
fi

# envbuilder does not yet support user settings
sed 's/\/\/.*$//g' ./devcontainer.json | jq -r -M '.customizations.settings' \
    > /root/.local/share/code-server/User/settings.json