# Setup questions to ask before the new request is rendered
#
# This can be used to dissuade requests for personal information.
#
# PublicBodyQuestion.build(
#   public_body: home_office,
#   key: :visa,
#   question: 'Asking about your Visa?',
#   response: 'Please contact {{public_body_name}} directly.'
# )
#
# PublicBodyQuestion.build(
#   public_body: home_office,
#   key: :foi,
#   question: 'Making an actual FOI request?',
#   response: :allow
# )
#
class PublicBodyQuestion
  def self.build(*args)
    @all ||= []
    @all << new(*args)
  end

  def self.fetch(public_body)
    @all.select { |q| q.public_body == public_body } if @all
  end

  attr_reader :public_body, :key, :response, :text

  def initialize(options = {})
    @public_body = options[:public_body]
    @key = options[:key]
    @text = options[:question]
    @response = options[:response]
  end

  def action
    response == :allow ? :allow : :deny
  end
end
