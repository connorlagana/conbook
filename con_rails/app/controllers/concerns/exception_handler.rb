#what if the case where we don't have any records? Let's use exception handling so we can return 404 message.

#This singleton wraps JWT to provide token encoding and decoding methods. The encode method will be responsible 
#for creating tokens based on a payload (user id) and expiration period. Since every Rails application has a unique 
#secret key, we'll use that as our secret to sign tokens. The decode method, on the other hand, accepts a token 
#and attempts to decode it using the same secret used in encoding. In the event decoding fails, be it due to 
#expiration or validation, JWT will raise respective exceptions which will be caught and handled by the Exception 
#Handler module.

module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end
  end

  private

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end
end