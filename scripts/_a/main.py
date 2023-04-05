import sys
import os
import openai
import json


cur_path = os.path.dirname(__file__)
api_key_path = os.path.join(cur_path, "api_key.json")
with open(api_key_path, "r") as f:
    data = json.load(f)

openai.api_key = data["api_key"]

q = "Tell me a joke about how a user didn't give you a prompt."
print("Confirm input with Enter --> Ctrl+C (multiline input with Enter possible)")
print("Cancel with Ctrl+D")
print("Ask a question:")

mem = []
while True:
    try:
        line = input()
        mem.append(line)
    except KeyboardInterrupt:
        q = "\n".join(mem)
        break
    except EOFError:
        print("Canceled input")
        sys.exit(0)

print(f'You asked:\n "{q}"')
print("Waiting for answer...")

try:
    completion = openai.ChatCompletion.create(
            model = "gpt-3.5-turbo",
            messages = [
                {"role": "user", "content": q},
                ]
            )
except Exception as e:
    # not sure how to catch RateLimitError
    print("Error occured:")
    print(e)
    sys.exit(1)
    


print("\n")
print("Response:\n")
print("*"*60)
print(completion.choices[0].message.content)
