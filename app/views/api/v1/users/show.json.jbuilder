json.users do
  json.(@user, :user_id, :email, :auth_token, :admin)
  json.(@user, :created_at, :updated_at, :last_touched_at)

  if @user.membership
    json.set! (@user.membership.ownership? ? :ownership : :membership) do
      json.partial! 'memberships/show', membership: @user.membership
    end
  end

  json.consents @user.consents do |consent|
    json.partial! 'consents/show', consent: consent
  end
end
