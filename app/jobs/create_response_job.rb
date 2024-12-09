class CreateResponseJob < ApplicationJob
  queue_as :default

  def perform(survey_id)
    survey = Survey.find(survey_id)
    ai_response = OpenaiService.create_response(survey)
    survey.create_response(ai_response: ai_response, status: 'completado')
    # Enviar correo al usuario (enviar_correo(survey))
  rescue => e
    survey.create_response(ai_response: 'Error: #{e.message}', status: 'fallido')
  end
end
