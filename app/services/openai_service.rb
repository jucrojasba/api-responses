require 'httparty'

class OpenaiService
  BASE_URL = 'https://api.openai.com/v1/chat/completions'
  API_KEY = ENV['OPENAI_API_KEY']

  def self.create_response(survey)
    # Preparar el mensaje para el modelo de chat
    messages = [
      { role: 'system', content: 'Eres un asistente útil.' },
      { role: 'user', content: "#{survey[:name]}: #{survey[:description]}" }
    ]

    # Log para depuración
    Rails.logger.debug "Enviando mensajes a OpenAI: #{messages}"

    response = HTTParty.post(BASE_URL, headers: {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{API_KEY}"
    }, body: {
      model: 'gpt-4',
      messages: messages,
      max_tokens: 100
    }.to_json)

    # Log de la respuesta
    Rails.logger.debug "Respuesta de OpenAI: #{response.parsed_response}"

    # Verificar si la respuesta es exitosa y contiene contenido
    if response.success? && response.parsed_response['choices'].present?
      response.parsed_response['choices'].first['message']['content']
    else
      # Manejar errores de manera adecuada
      'Error: No se pudo generar la respuesta.'
    end
  end
end
