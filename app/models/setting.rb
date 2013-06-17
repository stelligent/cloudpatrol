class Setting < ActiveRecord::Base
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
end
