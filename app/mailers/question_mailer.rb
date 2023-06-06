class QuestionMailer < ApplicationMailer
  default from: ' 1208215066@qq.com'
  def question_assigned(question)
    @question = question
    @project = question.project
    mail(to: @question.assigned_to, subject: "您有一项新的任务 - #{@question}")
  end
end
