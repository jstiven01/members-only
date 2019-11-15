# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token

  before_create :create_remember_token
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  class << self
    # Returns the hash digest of the given string.
    def digest(string)
      Digest::SHA1.hexdigest(string.to_s)
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest_bcrypt(string)
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end
  end

  # Remembers a user in the database for use in persistent sessions.

  def create_remember_token
    self.remember_token = User.new_token
    self.remember_digest = User.digest(remember_token)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    Digest::SHA1.hexdigest(digest.to_s).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
