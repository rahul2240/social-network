require 'rails_helper'

RSpec.describe User, type: :model do

  subject { User.new(name: "hello", email: 'rahul@gmail.com') }
  it "should be valid" do
    expect(subject).to be_valid
  end

  it "should have a name" do
    subject.name = "  "
    expect(subject).to_not be_valid
  end

  it "should have an email" do
    subject.email = " "
    expect(subject).to_not be_valid
  end

  it "should have an name which should not be too long" do
    subject.name = 'a'*50
    expect(subject).to_not be_valid
  end

  it "should have an email which should not be too long" do
    subject.email = 'a'*255 + '@example.com'
    expect(subject).to_not be_valid
  end

  it "email validation should accept valid emails" do
  valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                       first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
        subject.email = valid_address
        expect(subject).to be_valid
    end
  end

  it "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      subject.email = invalid_address
      expect(subject).to_not be_valid
    end
  end

  it "email should be unique" do
    user = User.new
    user.name="rahul"
    user.email = subject.email.dup
    subject.save
    expect(user).to_not be_valid
  end

  it "email should be case-insensitive" do
    user = User.new
    user.name="rahul"
    user.email = subject.email.upcase.dup
    subject.save
    expect(user).to_not be_valid
  end

  it "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    subject.email = mixed_case_email
    subject.save
    expect(subject.email).to match(mixed_case_email.downcase)
  end

end
