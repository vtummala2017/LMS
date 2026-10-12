FROM python:3.12-slim
WORKDIR /srv
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app app
ENV PORT=8000
# create tables once, then start 4 workers
CMD ["sh", "-c", "python -c 'from app.main import init_db; init_db()' && exec gunicorn -k uvicorn.workers.UvicornWorker -w ${WEB_CONCURRENCY:-4} -b 0.0.0.0:${PORT} --forwarded-allow-ips='*' --timeout 60 app.main:app"]
