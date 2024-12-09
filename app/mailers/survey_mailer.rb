class SurveyMailer < ApplicationMailer
  default from: 'jucrojasba@gmail.com'

  def response_ready_email(survey)
    @survey = survey
    mail(to: @survey.email, subject: 'Tu respuesta está lista')
  end
end
