require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(
      name: "Super Tester",
      email: "supertester@gmail.com",
      password: "confidential",
      password_confirmation: "confidential"
    )
  }

  describe "Validations" do
    it "save successfully with valid attributes" do
      subject.save
      expect(subject).to be_valid
      expect(subject.errors.full_messages).to be_empty
    end

    it 'should have password matching with password_confirmation' do
      subject.password = "niceperson"
      subject.password_confirmation = "person"
      subject.save
      expect(subject.password).not_to eq(subject.password_confirmation)
      expect(subject.errors.full_messages).to include ("Password confirmation doesn't match Password")

    end

    it 'should not save when password is no entered' do
      subject.password = nil
      subject.save
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include ("Password can't be blank")
    end

    it 'should not save when password_confirmation are not entered' do
      subject.password_confirmation = nil
      subject.save
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include ("Password confirmation can't be blank")
    end

    it 'should not save correctly if name is not entered' do
      subject.name = nil
      subject.save
      expect(subject.name).to be_nil
      expect(subject.errors.full_messages).to include ("Name can't be blank")
    end

    it 'should not save if email is not entered' do
      subject.email = nil
      subject.save
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include ("Email can't be blank")
    end

    it 'should not allow a new user to enter the same email address -> case-sensitivity' do
      same_as_subject = User.create(
        name: "Super Tester1",
        email: "supertester@gmail.com",
        password: "confidential",
        password_confirmation: "confidential"
      )
      subject.save
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include ("Email has already been taken")
    end

    it "is not valid when password is shorter than 5 characters" do
      subject.password = "nose"
      subject.password_confirmation = "nose"
      subject.save
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include ("Password is too short (minimum is 5 characters)")
    end

    it "is valid when password is exactly 5 characters" do
      subject.password = "roses"
      subject.password_confirmation = "roses"
      expect(subject).to be_valid
      expect(subject.errors.full_messages).to be_empty
    end
  end

  describe '.authenticate_with_credentials' do
    it "authenticates when credentials are valid" do
      subject.save!
      auth = User.authenticate_with_credentials(subject.email, subject.password)
      expect(auth).to eq subject
    end

    it "doesn't authenticate when email is incorrect" do
      subject.save!
      auth = User.authenticate_with_credentials("xyz@gmail.com", subject.password)
      expect(auth).to eq nil
    end

    it "doesn't authenticate when password is incorrect" do
      subject.save!
      auth = User.authenticate_with_credentials(subject.email, "incorrect")
      expect(auth).to eq nil
    end

    it "authenticates when email is correct but contains whitespace around it" do
      subject.save!
      auth = User.authenticate_with_credentials("   " + subject.email + "  ", subject.password)
      expect(auth).to eq subject
    end

    it "authenticates when email is correct but in the wrong case" do
      subject.save!
      auth = User.authenticate_with_credentials("SuperTester@GMail.cOM", subject.password)
      expect(auth).to eq subject
    end
  end

end
