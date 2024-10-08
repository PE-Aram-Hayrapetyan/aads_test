# frozen_string_literal: true

if model.failure?
  model.failure.each_key do |key|
    failures = model.failure[key].is_a?(Hash) ? model.failure[key].values : model.failure[key]
    json.set!(key.to_s.humanize, failures.join(', '))
  end
end
