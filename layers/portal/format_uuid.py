#!/usr/bin/env python3
import json
import sys
import base64
import uuid

def main():
    # Read input from stdin
    input_json = json.load(sys.stdin)
    raw_bytes = base64.b64decode(input_json['raw_bytes'])

    # Create UUID from bytes and get string representation
    uuid_obj = uuid.UUID(bytes=raw_bytes)

    # Return formatted result as proper UUID string
    result = {
        "uuid": str(uuid_obj)  # This will give us xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx format
    }

    # Output result as JSON
    json.dump(result, sys.stdout)

if __name__ == "__main__":
    main()