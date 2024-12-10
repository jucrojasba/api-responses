require 'httparty'

class OpenaiService
  BASE_URL = 'https://api.openai.com/v1/completions'
  API_KEY = ENV['OPENAI_API_KEY']

  def self.create_response(survey)
    prompt = "#{survey.name}: #{survey.description}"
    
    # Imprimir el prompt para verificar qué estamos enviando
    Rails.logger.debug "Enviando prompt a OpenAI: #{prompt}"

    response = HTTParty.post(BASE_URL, headers: {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{API_KEY}"
    }, body: {
      model: 'text-davinci-003',
      prompt: prompt,
      max_tokens: 100
    }.to_json)

    # Log de la respuesta para ver qué devuelve OpenAI
    Rails.logger.debug "Respuesta de OpenAI: #{response.parsed_response}"

    # Asegurarse de que la respuesta no está vacía y manejar los errores
    if response.success? && response.parsed_response['choices'].present?
      # Devolver la respuesta del modelo si está presente
      response.parsed_response['choices'].first['text']
    else
      # Si no hay respuesta o error, devolver un mensaje predeterminado
      'Error: No se pudo generar la respuesta.'
    end
  end
end
