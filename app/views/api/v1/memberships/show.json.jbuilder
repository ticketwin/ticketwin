json.memberships do
  json.partial! 'show', membership: @membership
end
