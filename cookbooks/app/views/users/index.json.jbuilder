json.array!(@users) do |user|
  json.extract! user, :id, :nombre, :dni, :fecha_alta, :direccion, :tel, :email, :fecha_nac
  json.url user_url(user, format: :json)
end
