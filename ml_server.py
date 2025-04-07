from flask import Flask, request, jsonify
from chatbot import answer_question
from flask_cors import CORS
import firebase_admin
from firebase_admin import credentials, auth

# 🔐 Load Firebase Service Account Key
cred = credentials.Certificate("firebase-service-account.json")
firebase_admin.initialize_app(cred)

app = Flask(__name__)
CORS(app)  # Enable access from Flutter

@app.route('/ask', methods=['POST'])
def ask():
    data = request.get_json()
    prompt = data.get("prompt", "")
    token = request.headers.get("Authorization", "").replace("Bearer ", "")

    if not prompt:
        return jsonify({"error": "Missing prompt"}), 400

    try:
        # 🔐 Verify Firebase token
        decoded_token = auth.verify_id_token(token)
        uid = decoded_token["uid"]
        print(f"✅ Authenticated user: {uid}")
    except Exception as e:
        return jsonify({"error": f"Unauthorized: {e}"}), 401

    try:
        response = answer_question(prompt)
        return jsonify({"response": response})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)