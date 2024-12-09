class SurveysController < ApplicationController
  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
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
      redirect_to surveys_path
    else
      render :new
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:name, :description, :processed_in_job)
  end
end