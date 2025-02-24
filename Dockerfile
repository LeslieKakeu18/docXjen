FROM python:3.13.0-alpine3.20

# Définition du répertoire de travail
WORKDIR /app

# Copier le script dans le conteneur
COPY sum.py /app/

# Garder le conteneur actif après le démarrage
CMD ["tail", "-f", "/dev/null"]
