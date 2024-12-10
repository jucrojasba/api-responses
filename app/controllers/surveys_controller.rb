class SurveysController < ApplicationController
  # Acción para mostrar todos los formularios
  def index
    @surveys = Survey.all  # Trae todos los formularios desde la base de datos
  end

  # Acción para crear un nuevo formulario
  def new
    @survey = Survey.new  # Inicializa un nuevo formulario vacío
  end

  # Acción para guardar un nuevo formulario
  def create
    @survey = Survey.new(survey_params)  # Crea un nuevo formulario con los parámetros recibidos
    if @survey.save
      if @survey.processed_in_job
        # Si se procesa en segundo plano
        CreateResponseJob.perform_later(@survey.id)
        flash[:notice] = 'Tu solicitud está en proceso. Te notificaremos cuando esté lista.'
      else
        # Si se procesa en el hilo principal
        OpenaiService.create_response(@survey)
        flash[:notice] = 'Formulario procesado con éxito.'
      end
      redirect_to surveys_path  # Redirige a la lista de formularios
    else
      render :new  # Si no se guarda correctamente, vuelve a mostrar el formulario
    end
  end

  private

  # Métodos para permitir los parámetros del formulario
  def survey_params
    params.require(:survey).permit(:name, :description, :processed_in_job, :email)
  end
end
