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

STOPSIGNAL SIGINT
ENTRYPOINT ["flask", "run", "--host", "0.0.0.0", "--without-threads"]
