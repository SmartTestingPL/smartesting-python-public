from http import HTTPStatus

import injector
from flask import Flask, jsonify, request
from flask_expects_json import expects_json
from flask_injector import FlaskInjector
from marshmallow import ValidationError
from prometheus_flask_exporter import PrometheusMetrics


from fraud_verifier.customer.customer_verifier import CustomerVerifier
from fraud_verifier.modules.feature_toggles import FeatureTogglesModule
from fraud_verifier.modules.fraud_verifier import FraudVerifierModule
from fraud_verifier.schemas import CustomerSchema, CustomerVerificationResultSchema
from fraud_verifier.tracing import setup_tracer

app = Flask(__name__)


@app.route("/customers/verify", methods=["POST"])
@expects_json()
def verify(verifier: CustomerVerifier):
    try:
        customer = CustomerSchema().load(request.json)  # type: ignore
    except ValidationError as validation_error:
        return jsonify(validation_error.messages), HTTPStatus.BAD_REQUEST

    result = verifier.verify(customer)
    result_schema = CustomerVerificationResultSchema()
    return result_schema.dump(result)


UNLEASH_TOKEN = "*:development.7acc69a05927e1751aed83f410a1ecb562cfbb0f0d57d05e02afd224"

container = injector.Injector(
    [FeatureTogglesModule(UNLEASH_TOKEN), FraudVerifierModule()],
    auto_bind=False,
)
FlaskInjector(app, injector=container)
setup_tracer("fraud-verifier", app)
PrometheusMetrics(app)
app.config["ZIPKIN_DSN"] = "http://zipkin:9411/api/v1/spans"
app.config["SECRET_KEY"] = "extra-secret"


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=9090)
