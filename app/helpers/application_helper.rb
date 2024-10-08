# frozen_string_literal: true

module ApplicationHelper
  def status(model)
    model.success? ? :ok : :unprocessable_entity
  end
end
