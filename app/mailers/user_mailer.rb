class UserMailer < ActionMailer::Base
  default from: "info1117@gmail.com"

  def welcome_email


    mail( :to => "info1117@gmail.com",
          :subject => "Thanks for signing up" )


  end

  def new_user(user)

    mail( :from => "rails-school.heroku.com",
          :to => "info1117@gmail.com",
          :subject => "New user " + user.name.to_s + "has registered!",
          :text => "So user's name is " + user.name.to_s + "!"
    )
    if user.subscribe
      mail( :from => "rails-school.heroku.com",
            :to => user.email,
            :subject => "Thank you for registration on Rails School!",
      )
    end

  end

end
