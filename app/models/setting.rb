class Setting < ActiveRecord::Base
  validates_presence_of :key, :value
  validates_uniqueness_of :key, case_sensitive: false
  before_validation :beautify_key

  def protect
    self.protected = true
    self.save
  end

  def unprotect
    self.protected = false
    self.save
  end

  def protected?
    self.protected
  end

private

  def beautify_key
    self.key = self.key.downcase.gsub(/[^a-z0-9_\s]/, "").gsub(/[_\s]+/, " ").squeeze(" ").strip.gsub(" ", "_")
  end
end
