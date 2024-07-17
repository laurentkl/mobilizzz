# Étape 1 : Utiliser l'image .NET SDK pour la construction de votre application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copier tous les fichiers de votre application dans le conteneur
COPY . ./

# Restaurer les dépendances et construire le projet
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Étape 2 : Utiliser l'image ASP.NET Core pour l'environnement d'exécution
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime-env
WORKDIR /app

# Copier les fichiers publiés depuis l'étape précédente
COPY --from=build-env /app/out .

# Exposer le port sur lequel l'application .NET Core écoute
EXPOSE 8080 

# Entrypoint pour démarrer l'application .NET Core
ENTRYPOINT ["dotnet", "Mobilizzz_BackEnd.dll"]

# Étape 3 : Utiliser la même image pour configurer PostgreSQL dans le même conteneur
FROM runtime-env AS final-env

# Installation de PostgreSQL
RUN apt-get update && \
    apt-get install -y postgresql

# Créer un utilisateur et une base de données PostgreSQL
USER postgres
RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER mobilitizzzuser WITH SUPERUSER PASSWORD 'toor';"

# Créer la base de données MobilitizzzDb avec l'utilisateur MobilitizzzUser
RUN    /etc/init.d/postgresql start &&\
    createdb -O mobilitizzzuser mobilitizzzdb

EXPOSE 5432 

# Revenir à l'utilisateur root pour exposer et exécuter l'application
USER root
