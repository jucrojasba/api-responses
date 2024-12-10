class CreateResponseJob < ApplicationJob
  queue_as :default

  def perform(survey_id)
    survey = Survey.find(survey_id)
    ai_response = OpenaiService.create_response(survey)
    
    # Crear la respuesta asociada a la encuesta
    response = survey.create_response(ai_response: ai_response, status: 'completado')

    # Enviar el correo al usuario cuando se cree la respuesta
    SurveyMailer.response_ready_email(survey).deliver_now
  rescue => e
    survey.create_response(ai_response: "Error: #{e.message}", status: 'fallido')
  end
end
