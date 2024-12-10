class SurveyMailer < ApplicationMailer
  default from: 'jucrojasba@gmail.com'

  def response_ready_email(survey)
    @survey = survey

    # Comprobamos si la encuesta tiene una respuesta asociada
    if @survey.response
      @status_message = @survey.response.ai_response
    else
      @status_message = "No hay respuesta disponible en este momento."
    end

    # Enviar el correo con el mensaje adecuado
    mail(to: @survey.email, subject: 'Tu respuesta está lista') do |format|
      format.text { render plain: "Tu respuesta está lista: #{@status_message}" }
      format.html { render html: "<p>Tu respuesta está lista: #{@status_message}</p>".html_safe }
    end
  end
end
