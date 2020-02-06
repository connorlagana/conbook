#Remember, our API returns json_response (JSON and an HTTP status code 200 by default).

module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end