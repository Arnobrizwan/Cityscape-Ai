from flask import Flask, request, jsonify
from chatbot import answer_question
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Enable access from Flutter/Postman

@app.route('/ask', methods=['POST'])
def ask():
    data = request.get_json()
    prompt = data.get("prompt", "")

    if not prompt:
        return jsonify({"error": "Missing prompt"}), 400

    try:
        response = answer_question(prompt)
        return jsonify({"response": response})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)