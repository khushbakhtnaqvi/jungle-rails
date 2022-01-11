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
      expect(subject).to be_valid
      expect(subject.errors.full_messages).to be_empty
    end

  end
end
