FROM python:3.13.0-alpine3.20

# Installer Python et les dépendances nécessaires
RUN apk add --no-cache python3 py3-pip

# Définition du répertoire de travail
WORKDIR /app

# Copier le script dans le conteneur
COPY sum.py /app/sum.py

# Garder le conteneur actif après le démarrage
CMD ["tail", "-f", "/dev/null"]
