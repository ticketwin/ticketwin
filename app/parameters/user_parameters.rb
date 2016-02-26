class UserParameters < Sparta::Parameters
  action :create, require: :users do
    require :email
    require :password
    require :password_confirmat
    permit  :some_optional_field

    require :consents do
      require :consent_type
      permit  :ip_address
    end
  end

  action :show, require: :users do
    permit :email
    permit :id
  end
end
