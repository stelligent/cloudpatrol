class Setting < ActiveRecord::Base

  before_validation :beautify_key
  validates_presence_of :key
  validates_uniqueness_of :key, case_sensitive: false
  validates_inclusion_of :protected, in: ["none", "key", "both"]

  def key_protected?
    if self.protected == "key" or self.protected == "both"
      true
    else
      false
    end
  end

  def value_protected?
    if self.protected == "both"
      true
    else
      false
    end
  end

private

  def beautify_key
    self.key = self.key.downcase.gsub(/[^a-z0-9_\s]/, "").gsub(/[_\s]+/, " ").squeeze(" ").strip.gsub(" ", "_")
  end

end
