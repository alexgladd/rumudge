##
## environment
##

require 'logger'

class Rumudge::Environment
  @@current = :development
  @@logger = Logger.new(STDOUT)

  def self.is_production?
    @@current == :production
  end

  def self.is_development?
    @@current == :development
  end

  def self.production
    @@current = :production

    # log level to warn
    @@logger.level = Logger::WARN
  end

  def self.logger
    @@logger
  end

  def self.logger=(logger)
    unless logger.is_a? Logger
      raise ArgumentError, 'Argument must be a Logger object'
    end

    @@logger = logger

    if self.is_production?
      @@logger.level = Logger::WARN
    end
  end
end
