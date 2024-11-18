module ArticlesHelper
  def mes_dia_ano(datetime)
    datetime.strftime('%B %e, %Y')
  end
end
# nessa pasta ficam os métodos que criei para usar nas views. Essa formatação do date time é feita conforme o site https://apidock.com/ruby/DateTime/strftime