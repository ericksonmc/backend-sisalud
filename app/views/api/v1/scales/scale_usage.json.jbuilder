# frozen_string_literal: true

json.array! @scales_services.each do |service|
  json.title service[0]
  json.cantidad service[1]
  json.total service[2]
end
