from flask import Flask, request, jsonify
from flask_cors import CORS
import boto3
import uuid
from datetime import datetime

app = Flask(__name__)

CORS(app, resources={
    r"/contact": {
        "origins": "http://emmanuel-cloud-portfolio.s3-website-us-east-1.amazonaws.com"
    }
})

dynamodb = boto3.resource("dynamodb", region_name="us-east-1")
table = dynamodb.Table("PortfolioMessages")


@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "ok"}), 200


@app.route("/contact", methods=["POST", "OPTIONS"])
def contact():
    if request.method == "OPTIONS":
        return "", 200

    data = request.json

    table.put_item(
        Item={
            "message_id": str(uuid.uuid4()),
            "email": data["email"],
            "message": data["message"],
            "timestamp": datetime.utcnow().isoformat()
        }
    )

    return jsonify({"message": "Message received"}), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
