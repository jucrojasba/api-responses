# Surveys App

Esta es una aplicación de Rails para gestionar formularios y procesar respuestas. Está diseñada para facilitar la creación, visualización y procesamiento de encuestas utilizando un backend basado en Ruby on Rails.

## Requisitos

Antes de comenzar, asegúrate de tener instalado en tu sistema:

- **Ruby**: Versión compatible con el proyecto (indicado en el archivo `.ruby-version`, si está presente).
- **Bundler**: Para instalar las gemas requeridas.
- **Redis**: Para manejar los trabajos en segundo plano con Sidekiq.
- **PostgreSQL**: (o el gestor de base de datos definido en `config/database.yml`).

## Instalación

Sigue estos pasos para configurar y ejecutar el proyecto en un entorno Linux:

1. Clona este repositorio:

   ```bash
   git clone https://github.com/jucrojasba/api-responses.git
   cd surveys-app
   ```

2. Instala las dependencias del proyecto:

   ```bash
   bundle install
   ```

3. Configura la base de datos:

   ```bash
   rails db:setup
   ```

   Esto crea y migra la base de datos, además de poblarla con datos iniciales (si se define en el archivo `db/seeds.rb`).

4. Inicia Sidekiq en una terminal para procesar trabajos en segundo plano:

   ```bash
   bundle exec sidekiq
   ```

5. En otra terminal, inicia el servidor Rails:

   ```bash
   rails s
   ```

6. Abre tu navegador y accede a la aplicación en [http://localhost:3000](http://localhost:3000).

## Estructura del proyecto

El proyecto sigue el patrón **MVC (Model-View-Controller)**. A continuación, una breve descripción de las partes principales:

- **Modelos**:
  - `Survey`: Representa un formulario o encuesta.
  - `Response`: Contiene las respuestas asociadas a cada formulario.
- **Controladores**:
  - `SurveysController`: Maneja las acciones relacionadas con los formularios (crear, listar, mostrar).
- **Vistas**:
  - Diseñadas con **TailwindCSS** para una interfaz moderna y responsiva.
- **Trabajos en segundo plano**:
  - Implementados con **Sidekiq** para tareas como el procesamiento de respuestas.

## Notas adicionales

- Asegúrate de que Redis esté corriendo antes de iniciar Sidekiq. Puedes iniciar Redis con el comando:

   ```bash
   redis-server
   ```

- Si necesitas modificar configuraciones de base de datos, edita el archivo `config/database.yml`.

- En caso de problemas, revisa los logs de Rails y Sidekiq para más detalles.
