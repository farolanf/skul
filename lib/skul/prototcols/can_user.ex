alias Skul.Accounts.User

defimpl Can, for: User do

  # actions: :create, :read, :update, :delete

  # owners can update their own things
  def can?(%User{id: id}, action, %{user_id: user_id})
      when action in [:update] do
    user_id == id
  end

  # deny unknown actions
  def can?(%User{}, _, _), do: false

end
