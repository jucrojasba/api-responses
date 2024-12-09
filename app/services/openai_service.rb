require 'httparty'

class OpenaiService
  BASE_URL = 'https://api.openai.com/v1/completions'
  API_KEY = ENV['OPENAI_API_KEY']

  def self.create_response(survey)
    prompt = "#{survey.name}: #{survey.description}"
    response = HTTParty.post(BASE_URL, headers: {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{API_KEY}"
    }, body: {
      model: 'text-davinci-003',
      prompt: prompt,
      max_tokens: 100
    }.to_json)

    response.parsed_response['choices'].first['text']
  end
end
