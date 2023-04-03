import openai
import json

with open("api_key.json", "r") as f:
    data = json.load(f)

openai.api_key = data["api_key"]

q = input("Ask GPT a question: ")

completion = openai.ChatCompletion.create(
        model = "gpt-3.5-turbo",
        messages = [
            {"role": "user", "content": q},
            ]
        )


print(completion.choices[0].message.content)
