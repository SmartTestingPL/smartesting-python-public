FROM python:3.11

ENV USERNAME python
RUN mkdir /app

RUN useradd -ms /bin/bash ${USERNAME}
RUN chown ${USERNAME} /app
USER ${USERNAME}

WORKDIR /app
RUN pip install poetry==1.6.1
ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"
COPY poetry.lock pyproject.toml /app/

RUN poetry config virtualenvs.create false && poetry export -f requirements.txt --output requirements.txt && pip install --user -r requirements.txt

COPY ./smarttesting /app/smarttesting
COPY ./smarttesting_main /app/smarttesting_main
COPY ./smarttesting_api /app/smarttesting_api
COPY ./tests /app/tests

STOPSIGNAL SIGINT
ENV FLASK_APP smarttesting.web_app:app
ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "4", "--access-logfile", "-", "smarttesting_api.web_app:app"]
