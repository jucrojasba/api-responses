class SurveysController < ApplicationController
  # Acción para mostrar todos los formularios
  def index
    @surveys = Survey.all
  end

  # Acción para crear un nuevo formulario
  def new
    @survey = Survey.new
  end

  # Acción para guardar un nuevo formulario
  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      if @survey.processed_in_job
        CreateResponseJob.perform_later(@survey.id)
        flash[:notice] = 'Tu solicitud está en proceso. Te notificaremos cuando esté lista.'
      else
        OpenaiService.create_response(@survey)
        flash[:notice] = 'Formulario procesado con éxito.'
      end
      redirect_to survey_path(@survey)  # Redirige a la página individual del formulario recién creado
    else
      render :new
    end
  end

  # Acción para mostrar un formulario específico
  def show
    @survey = Survey.find(params[:id])  # Encuentra el formulario por su ID
  end

  private

  # Métodos para permitir los parámetros del formulario
  def survey_params
    params.require(:survey).permit(:name, :description, :processed_in_job, :email)
  end
end
