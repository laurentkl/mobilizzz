# Utiliser l'image de base PostgreSQL
FROM postgres:latest

# Créer un utilisateur et une base de données PostgreSQL
ENV POSTGRES_DB mobilitizzzdb
ENV POSTGRES_USER mobilitizzzuser
ENV POSTGRES_PASSWORD toor

# Copier les fichiers de configuration locaux dans le conteneur
# COPY ./pg_hba.conf /etc/postgresql/pg_hba.conf
# COPY ./postgresql.conf /etc/postgresql/postgresql.conf

COPY ./mobilitizzz_ForDockerContainer.sql /dump.sql

# Exposer le port par défaut de PostgreSQL (5432)
EXPOSE 5432