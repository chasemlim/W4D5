# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:testuser) { User.create(username: "testdude", password: "password") }
  describe 'testing validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_uniqueness_of :username }
    it { should validate_uniqueness_of :session_token }
  end
  
  describe 'testing associations' do
    it { should have_many :goals }
  end
  
  describe 'upon initialization' do
    it "creates a password digest when a password is given" do
      expect(testuser.password_digest).to_not be_nil
    end

    it "creates a session token before validation" do
      testuser.valid?
      expect(testuser.session_token).to_not be_nil
    end
  end
  
  describe 'class scope methods' do
    describe "#reset_session_token!" do
      it "sets a new session token on the user" do
        testuser.valid?
        old_session_token = testuser.session_token
        testuser.reset_session_token!

        # Miniscule chance this will fail.
        expect(testuser.session_token).to_not eq(old_session_token)
      end

      it "returns the new session token" do
        expect(testuser.reset_session_token!).to eq(testuser.session_token)
      end
    end

    describe "#is_password?" do
      it "verifies a password is correct" do
        expect(testuser.is_password?("password")).to be true
      end

      it "verifies a password is not correct" do
        expect(testuser.is_password?("aewfawfawe")).to be false
      end
    end

    describe ".find_by_credentials" do
      before { testuser.save! }

      it "returns user given good credentials" do
        expect(User.find_by_credentials("testdude", "password")).to eq(testuser)
      end

      it "returns nil given bad credentials" do
        expect(User.find_by_credentials("testing_duderino", "awefefa")).to eq(nil)
      end
    end
  end
end
