# Usa una imagen base oficial de Ruby de Docker Hub
FROM ruby:3.3.1

# Instala dependencias del sistema
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Configura el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo Gemfile y Gemfile.lock al directorio de trabajo
COPY Gemfile Gemfile.lock ./

# Instala las gemas especificadas en Gemfile
RUN bundle install

# Copia el resto de la aplicación al contenedor
COPY . .

# Precompila los activos de la aplicación
RUN RAILS_ENV=production SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# Limpia la caché de activos
RUN rm -rf /app/tmp/cache/assets/

# Expon el puerto de la aplicación
EXPOSE 3000

# Define el comando de inicio de la aplicación
CMD ["rails", "server", "-b", "0.0.0.0"]