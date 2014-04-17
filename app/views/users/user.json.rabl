object @user
node(:some_count) { |m| @user.email }
child(@user) { attribute :email }