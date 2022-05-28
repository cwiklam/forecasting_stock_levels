module Response
  def json_response(object = {}, status = :ok)
    render json: object, status: status
  end

  def successfully_response(object:, notice:, path:)
    respond_to do |format|
      format.html do
        if path.present?
          redirect_to path, notice: notice
        end
      end
      format.json do
        json_response(object)
      end
    end
  end

  def not_valid_response(object:, action:, status: 400)
    respond_to do |format|
      format.html do
        render action, status: 400
      end
      format.json do
        json_response({ error: object.errors.messages }, status)
      end
    end
  end
end
