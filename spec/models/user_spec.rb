# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  first_name :string
#  is_public  :boolean
#  last_name  :string
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  def create_a_user(email: "#{SecureRandom.hex(4)}@example.org")
    User.create!(
      first_name: "Adam",
      email: email,
      username: SecureRandom.hex(4),
    )
  end

  describe "#valid?" do
    it "is valid when email is unique" do
      user1 = create_a_user
      user2 = create_a_user

      expect(user2.email).not_to be user1.email
      expect(user2).to be_valid
    end

    it "is invalid if the username is taken" do
      user = create(:user, username: "a", email: "#{SecureRandom.hex(4)}@example.org")
      another_user = create(:user, username: "b", email: "#{SecureRandom.hex(4)}@example.org")

      expect(another_user).to be_valid
      another_user.username = user.username
      expect(another_user).not_to be_valid
    end

    it "is invalid if user's first name is blank" do
      user = create_a_user
      expect(user).to be_valid

      user.first_name = ""
      expect(user).not_to be_valid

      user.first_name = nil
      expect(user).not_to be_valid
    end
  end

  describe "#email" do
    it "is invalid if the email looks bogus" do
      user = create_a_user
      expect(user).to be_valid

      user.email = ""
      expect(user).to be_invalid

      user.email = "foo.bar"
      expect(user).to be_invalid

      user.email = "foo.bar#example.com"
      expect(user).to be_invalid

      user.email = "f.o.o.bar@example.com"
      expect(user).to be_valid

      user.email = "foo+bar@example.com"
      expect(user).to be_valid

      user.email = "foo.bar@sub.example.co.id"
      expect(user).to be_valid
    end
  end
  
  decribe "#followings" do
    it "can list all of the user's followings" do
      user = create_a_user
      friend1 = create_a_user
      friend2 = create_a_user
      friend3 = create_a_user

      bond.create user: user,
        friend: friend1,
        state: Bond::FOLLOWING
      
      bond.create user: user,
        friend: friend2,
        state: Bond::FOLLOWING
      
      bond.create user: user,
        friend: friend3,
        state: Bond::FOLLOWING

      expect(user.followings).to include(friend1, friend2)
      expect(user.follow_requests).to include(friend3)
    end
  end
  
  describe "#followers" do
    it "can list all of the user's folloers" do
      user1 = create_a_user
      user2 = create_a_user

      fol1 = create_a_user
      fol2 = create_a_user
      fol3 = create_a_user
      fol4 = create_a_user

      Bond.create user: fol1,
        friend: user1,
        state: Bond::FOLLOWING
      
      Bond.create user: fol2,
        friend: user1,
        state: Bond::FOLLOWING
      
      Bond.create user: fol3,
        friend: user3,
        state: Bond::FOLLOWING
      
      Bond.create user: fol4,
        friend: user4,
        state: Bond::FOLLOWING
    
      expect(user1.followers).to eq([fol1, fol2])
      expect(user1.followers).to eq([fol3])
    end
    
  end
end
