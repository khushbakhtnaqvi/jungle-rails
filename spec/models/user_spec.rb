require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "Validations" do

    user = User.create({
      name: "Super Tester",
      email: "supertester@gmail.com",
      password: "confidential",
      password_confirmation: "confidential"
  })

    it "save successfully with valid attributes" do
      user.save
      expect(user).to be_valid
      expect(user.errors.full_messages).to be_empty
    end

    it 'should have password matching with password_confirmation' do
      user.password = "niceperson"
      user.password_confirmation = "person"
      user.save
      expect(user.password).not_to eq(user.password_confirmation)
      expect(user.errors.full_messages).to include ("Password confirmation doesn't match Password")

    end

    it 'should not save when password is no entered' do
      user.password = nil
      user.save
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include ("Password can't be blank")
    end

    it 'should not save when password_confirmation are not entered' do
      user.password_confirmation = nil
      user.save
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include ("Password confirmation can't be blank")
    end

    it 'should not save correctly if name is not entered' do
      user1 = user
      user1.name = nil
      user1.save
      expect(user1.name).to be_nil
      expect(user.errors.full_messages).to include ("Name can't be blank")
    end

    it 'should not save if email is not entered' do
      user2 = user
      user2.email = nil
      user2.save
      expect(User.find_by(id: 2)).to be_nil
      expect(user.errors.full_messages).to include ("Email can't be blank")
    end

    it 'should not allow a new user to enter the same email address -> case-sensitivity' do
      user2 = user
      user2.email = "supertester@gmail.com"
      user2.save
      expect(User.find_by(id: 2)).to be_nil
      expect(user.errors.full_messages).to include ("Email has already been taken")
    end

    it 'should not save if password is less than 5 characters' do
      user3 = user
      user3.password = "12"
      user3.password_confirmation = "12345"
      user3.save
      expect(User.find_by(id: 3)).to be_nil
      expect(user.errors.full_messages).to include ("Password is too short (minimum is 5 characters)")
    end
    
  end
end
