class BloggerException
  def initialize
    @file = $0
    @line = $!.backtrace[0].split(':')[1]
    @cause = $!.backtrace[0].split('`')[-1]
    @message = $!.message
    @type = $!.class.to_s
    @description = generate_description(self.type.to_sym)
    @scope = $!.backtrace[0].split(/\./)[0]
    @time = Time.now.strftime("%I:%M:%S %p")
    @date = Time.now.strftime("%m/%d/%y")
  end

  DESCRIPTIONS = {
    ZeroDivisionError: "Attempting to divide an Integer by 0.", 
    NoMethodError: "A method is called on a receiver that does not have that method defined."
  }

  def to_s
    <<~MLS 
    :file: #{file}
    :line: #{line}
    :cause: #{cause}
    :message: #{message}
    :type: #{type}
    :description #{description}
    :scope: #{scope}
    :time: #{time}
    MLS
  end

  def display
    puts <<~MLS
    \tClass #{self.type}
    \tDescription: #{self.description}
    \tLine: #{self.line}
    \tTime: #{self.time}
    \tDate: #{self.date}
    MLS
  end

  def log
    File.open('structured_exceptions.yml', 'a+') do |file|
      file.write (self.to_yaml)
    end 
    puts 'Bug Logged Successfully:'
  end

  def generate_description(type)
    return DESCRIPTIONS[type] if DESCRIPTIONS.key?(type)
    return 'Check out https://ruby-doc.org/core-2.7.0/Exception.html for more information.'
  end

  attr_reader :file, :line, :type, 
              :description, :time, :date
private
  attr_reader :cause,
              :message, 
              :scope
end