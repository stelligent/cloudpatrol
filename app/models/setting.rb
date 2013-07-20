class Setting < ActiveRecord::Base

  before_validation :ensure_protection, if: -> { protected.blank? }
  before_validation :beautify_key, unless: -> { key.blank? }

  before_update :filter_protected
  before_destroy :keep_protected

  validates_presence_of :key
  validates_uniqueness_of :key, case_sensitive: false
  validates_inclusion_of :protected, in: ["none", "key", "both"]

  def key_protected?
    self.protected == "key" or self.protected == "both"
  end

  def value_protected?
    self.protected == "both"
  end

  def self.to_hash
    hash = {}
    all.each do |s|
      hash[s.key.to_sym] = s.value if s.value.present?
    end
    hash
  end

private

  def ensure_protection
    self.protected = "key"
  end

  def beautify_key
    self.key = self.key.downcase.gsub(/[^a-z0-9_\s]/, "").gsub(/[_\s]+/, " ").squeeze(" ").strip.gsub(" ", "_")
  end

  def filter_protected
    !(self.key_changed? and self.key_protected? or self.value_changed? and self.value_protected?)
  end

  def keep_protected
    !self.key_protected?
  end
end
