import time

import requests
from flask import Flask
from opentelemetry import trace
from opentelemetry.exporter.zipkin.proto.http import ZipkinExporter
from opentelemetry.instrumentation.pymongo import PymongoInstrumentor
from opentelemetry.instrumentation.requests import RequestsInstrumentor
from opentelemetry.instrumentation.flask import FlaskInstrumentor
from opentelemetry.sdk.resources import SERVICE_NAME, Resource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor


def setup_tracer(service_name: str, app: Flask) -> None:
    wait_until_zipkin_available()
    zipkin_host = "zipkin"
    resource = Resource(attributes={SERVICE_NAME: service_name})
    zipkin_exporter = ZipkinExporter(endpoint=f"http://{zipkin_host}:9411/api/v2/spans")
    provider = TracerProvider(resource=resource)
    processor = BatchSpanProcessor(zipkin_exporter)
    provider.add_span_processor(processor)
    RequestsInstrumentor().instrument()
    PymongoInstrumentor().instrument()
    FlaskInstrumentor().instrument_app(app)
    trace.set_tracer_provider(provider)


def wait_until_zipkin_available() -> None:
    start = time.time()
    while time.time() - start < 60:
        try:
            requests.get("http://zipkin:9411/zipkin/")
            print("Zipkin available!")
            return
        except Exception:
            time.sleep(0.5)

    raise Exception("Zipkin is not available")
