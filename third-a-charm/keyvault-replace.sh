#!/bin/bash

# Check if required arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_file> <keyvault_name>"
    exit 1
fi

INPUT_FILE=$1
KEYVAULT_NAME=$2

# Read the input file
CONTENT=$(cat "$INPUT_FILE")

# Find all placeholders in the form ${keyName}
PLACEHOLDERS=$(awk '{
    while (match($0, /\$\{[^}]+\}/)) {
        keyName = substr($0, RSTART + 2, RLENGTH - 3)
        print keyName
        $0 = substr($0, RSTART + RLENGTH)
    }
}' "$INPUT_FILE" | sort | uniq)

# Replace each placeholder with the corresponding KeyVault secret
for PLACEHOLDER in $PLACEHOLDERS; do
    SECRET=$(az keyvault secret show --vault-name "$KEYVAULT_NAME" --name "$PLACEHOLDER" --query value -o tsv)

    if [ $? -ne 0 ]; then
        echo "Failed to retrieve secret for key: $PLACEHOLDER"
        exit 1
    fi

    ESCAPED_SECRET=$(printf '%s\n' "$SECRET" | sed -e 's/[\/&]/\\&/g' -e 's/\$/\\$/g')
    CONTENT=$(echo "$CONTENT" | sed "s/\${$PLACEHOLDER}/$ESCAPED_SECRET/g")
    #echo "Replacing secret for key: $ESCAPED_SECRET"
done
#
## Output the modified content
echo "$CONTENT"
