FROM python:3.11-slim

WORKDIR /app

# Pillow 需要 libjpeg/zlib；LibreOffice 与中文字体用于忠实渲染 PPT 页面，
# 让线上版的图表、公式和版式与原稿一致。
RUN apt-get update && apt-get install -y --no-install-recommends \
    libjpeg-dev \
    zlib1g-dev \
    libreoffice-impress \
    fonts-noto-cjk \
    && rm -rf /var/lib/apt/lists/*

# 安装 Python 依赖
COPY ran-backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制后端代码
COPY ran-backend/ ./ran-backend/

# 复制前端静态文件（保持目录名与本地一致）
COPY ["ran-page 3/", "./ran-page 3/"]

# 环境变量
ENV PORT=8000
ENV RAN_MODE=public
ENV PYTHONUNBUFFERED=1

WORKDIR /app/ran-backend

EXPOSE 8000

# 启动命令：端口从环境变量读取
CMD uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}
