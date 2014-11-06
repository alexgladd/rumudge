##
## logging
##

class Log
  def self.d(tag, msg)
    self.log(:debug, tag, msg)
  end

  def self.i(tag, msg)
    self.log(:info, tag, msg)
  end

  def self.w(tag, msg)
    self.log(:warn, tag, msg)
  end

  def self.e(tag, msg)
    self.log(:error, tag, msg)
  end

  def self.f(tag, msg)
    self.log(:fatal, tag, msg)
  end

  def self.a(tag, msg)
    self.log(:unknown, tag, msg)
  end

  private

  def self.log(method = :info, tag = 'NONE', msg = '')
    logger = Rumudge::Environment.logger

    begin
      lm = logger.method(method)
      lm.call("[#{tag}] > #{msg}")
    rescue
      logger.warn("Can't log message with method #{method}")
    end
  end
end
